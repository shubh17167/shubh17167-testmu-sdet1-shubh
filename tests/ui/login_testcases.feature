VALID LOGIN SCENARIOS:

Scenario: Successful login with valid credentials
Given the user is on the Login page
When the user enters a registered email and valid password
And clicks the Login button
Then the user should be redirected to the Dashboard
And a valid session should be created
And the session cookie should be marked as HttpOnly and Secure


Scenario: Successful login using email with leading/trailing spaces:

Given the user is on the Login page
When the user enters a registered email with leading or trailing spaces
And enters a valid password
And clicks Login
Then the system should trim spaces
And authenticate the user successfully


Scenario: Login using minimum password length (boundary valid):
Given the minimum password length is 8 characters
And the user is registered with an 8 character password
When the user enters valid email and 8 character password
Then login should be successful

Scenario: Login using maximum password length (boundary valid):
Given the maximum password length is 64 characters
And the user is registered with a 64 character password
When the user enters valid credentials
Then login should be successful


INVALID CREDENTIAL SCENARIOS:

Scenario: Login fails with incorrect password
Given the user is on the Login page
When the user enters a valid registered email
And enters an incorrect password
And clicks Login
Then the system should display a generic error message "Invalid credentials"
And the user should remain on the Login page

Scenario: Login fails with unregistered email
Given the user is on the Login page
When the user enters an unregistered email
And enters any password
Then the system should display a generic error message
And no information about email validity should be revealed

Scenario: Login fails when email is empty
Given the user is on the Login page
When the user leaves email blank
And enters a password
And clicks Login
Then a validation message "Email is required" should be displayed
And login request should not be sent to the server

Scenario: Login fails when password is empty
Given the user is on the Login page
When the user enters a valid email
And leaves password blank
Then a validation message "Password is required" should be displayed
And login request should not be processed


Scenario: Login fails when both fields are empty
Given the user is on the Login page
When the user clicks Login without entering credentials
Then validation messages should appear for both fields

Scenario: Login fails with SQL injection attempt
Given the user is on the Login page
When the user enters "' OR 1=1 --" in the email field
And enters any password
Then the system should prevent authentication
And the input should be sanitized
And an error message should be shown

Scenario: Login input should prevent XSS
Given the user is on the Login page
When the user enters "<script>alert(1)</script>" in the email field
Then the script should not execute
And the input should be safely handled

Scenario: Login with input exceeding maximum length
Given the maximum email length is 255 characters
When the user enters an email longer than 255 characters
Then the system should prevent submission
And display appropriate validation error


FORGOT PASSWORD SCENARIOS:

Scenario: Reset password with registered email
Given the user is on the Login page
When the user clicks on Forgot Password
And enters a registered email
Then a password reset link should be sent to the email
And a generic success message should be displayed

Scenario: Reset password with unregistered email
Given the user is on Forgot Password page
When the user enters an unregistered email
Then a generic success message should be displayed
And system should not reveal email existence

Scenario: Expired reset link should not work
Given the user clicks on an expired password reset link
When the user attempts to set a new password
Then the system should show "Reset link expired"
And prompt user to request a new reset link

Scenario: Prevent reuse of reset token
Given the user has successfully reset password once
When the user attempts to reuse the same reset link
Then the system should invalidate the token
And show an error message

SESSION EXPIRY SCENARIOS:

Scenario: User session expires after inactivity timeout
Given the user is logged in
And session timeout is set to 15 minutes
When the user remains inactive for 15 minutes
Then the session should expire
And user should be redirected to Login page

Scenario: Prevent access after session expiration
Given the user's session has expired
When the user tries to access Dashboard URL directly
Then the user should be redirected to Login page
And no protected data should be visible

Scenario: Session cannot be reused after logout
Given the user logs out successfully
When the user tries to reuse old session cookie
Then the system should reject the session
And redirect to Login page


BRUTE-FORCE LOCKOUT PROTECTION:

Scenario: Account locks after 5 failed login attempts
Given the user has failed login 4 times
When the user enters incorrect password on 5th attempt
Then the account should be locked
And a lockout message should be displayed

Scenario: Prevent login during lock period
Given the account is locked due to failed attempts
When the user tries to login with correct credentials
Then login should be denied
And user should see lockout duration message

Scenario: Account unlocks after lock duration
Given the account was locked for 30 minutes
When 30 minutes have passed
And user attempts login with correct credentials
Then login should be successful

Scenario: Detect distributed brute-force attack
Given multiple failed attempts across different accounts from same IP
When failed attempts exceed threshold within defined time window
Then the system should block the IP temporarily
And log security event

Scenario: CAPTCHA appears after repeated failures
Given user has failed login 3 consecutive times
When user attempts login again
Then a CAPTCHA challenge should be displayed
And authentication should proceed only after successful CAPTCHA validation

ADDITIONAL SECURITY EDGE CASES:

Scenario: Password field should mask input
Given the user types password in password field
Then characters should appear masked
And should not be visible in plain text

Scenario: Sensitive fields should not store plain passwords
Given the login page is loaded
Then the password field should have autocomplete disabled or properly controlled

Scenario: Login page should enforce HTTPS
Given the user tries to access login page via HTTP
Then the system should automatically redirect to HTTPS


