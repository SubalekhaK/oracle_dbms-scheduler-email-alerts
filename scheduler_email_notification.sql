--------------------------------------------------------------------------------
-- Oracle ACE Apprentice Task
-- Topic: DBMS_SCHEDULER Job with Email Notification
--------------------------------------------------------------------------------

-- Step 1: Create a Test Procedure
CREATE OR REPLACE PROCEDURE test_success_proc IS
BEGIN
  DBMS_OUTPUT.PUT_LINE('Test job executed successfully.');
END;
/

-- Step 2: Create the Scheduler Job (Manual Start Only)
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name   => 'TEST_JOB',
    job_type   => 'STORED_PROCEDURE',
    job_action => 'TEST_SUCCESS_PROC',
    enabled    => FALSE
  );
END;
/

-- Step 3: Configure Scheduler Email Attributes
BEGIN
  DBMS_SCHEDULER.set_scheduler_attribute('email_server', 'smtp.tfsin.co.in:25');
  DBMS_SCHEDULER.set_scheduler_attribute('email_sender', 'bot@tfsin.co.in');
END;
/

-- Step 4: Configure Email Notification for Job Events
BEGIN
 DBMS_SCHEDULER.add_job_email_notification (
  job_name   => 'TEST_JOB',
  recipients => 'subalekha.kumaravel@infolob.com',
  subject    => 'ALERT: TEST_JOB Status Notification',
  body       => 'This is a test mail from DBMS_SCHEDULER.',
  events     => 'job_started,job_succeeded,job_failed'
 );
END;
/

-- Step 5: Manually Run the Job
BEGIN
  DBMS_SCHEDULER.RUN_JOB(job_name => 'TEST_JOB');
END;
/

-- Step 6: Remove Email Notification
BEGIN
  DBMS_SCHEDULER.REMOVE_JOB_EMAIL_NOTIFICATION(
    job_name => 'TEST_JOB'
  );
END;
/

-- Step 7: Drop Job
BEGIN
  DBMS_SCHEDULER.DROP_JOB(
    job_name => 'TEST_JOB',
    force    => TRUE
  );
END;
/

-- Step 8: Drop Procedure
DROP PROCEDURE test_success_proc;
