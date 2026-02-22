 Feature: REST API Validation for Test Management Platform
 

  Scenario: Access protected endpoint with valid auth token
  Given a valid JWT auth token is generated for a registered user
  When the client sends a GET request to "/api/projects" with the valid token
  Then the response status code should be 200
  And the response body should contain a list of projects
  And the response time should be under 2 seconds

  Scenario: Access protected endpoint without auth token
  Given no auth token is provided
  When the client sends a GET request to "/api/projects"
  Then the response status code should be 401
  And the response body should contain error code "AUTH_TOKEN_MISSING"

  Scenario: Access with expired auth token
  Given an expired JWT auth token
  When the client sends a GET request to "/api/projects" with expired token
  Then the response status code should be 401
  And the error message should indicate "Token expired"

  Scenario: Access with tampered token
  Given a JWT token with modified payload but invalid signature
  When the client sends a GET request to "/api/projects"
  Then the response status code should be 401
  And the system should log a security audit entry


  
  Scenario: Create test case with valid payload
  Given a valid auth token
  And a valid JSON payload with mandatory fields:
    | title        | Login test case |
    | priority     | High            |
    | project_id   | 101             |
  When the client sends a POST request to "/api/testcases"
  Then the response status code should be 201
  And the response should contain a generated "id"
  And the returned data should match the request payload
  And the database should persist the record

  Scenario: Create test case with missing title
  Given a valid auth token
  And a JSON payload without "title"
  When the client sends a POST request to "/api/testcases"
  Then the response status code should be 400
  And the error message should indicate "title is required"

  Scenario: Create test case with title exceeding max length
  Given a valid auth token
  And a JSON payload where title length exceeds 255 characters
  When the client sends a POST request to "/api/testcases"
  Then the response status code should be 400
  And the error message should indicate validation failure



  Scenario: Get test case by valid ID
  Given a valid auth token
  And a test case exists with ID 2001
  When the client sends a GET request to "/api/testcases/2001"
  Then the response status code should be 200
  And the response schema should match predefined JSON schema
  And the returned ID should be 2001
  
  Scenario: Get test case with non-existing ID
  Given a valid auth token
  When the client sends a GET request to "/api/testcases/999999"
  Then the response status code should be 404
  And the error message should indicate "Resource not found"

  
  Scenario: Update existing test case
  Given a valid auth token
  And a test case exists with ID 2001
  When the client sends a PUT request to "/api/testcases/2001" with updated priority = "Medium"
  Then the response status code should be 200
  And the response body should reflect updated priority
  And the database record should be updated

  Scenario: Update with invalid priority value
  Given a valid auth token
  When the client sends a PUT request with priority = "CriticalHigh"
  Then the response status code should be 400
  And the validation error should mention invalid enum value



  Scenario: Delete existing test case
  Given a valid auth token
  And a test case exists with ID 2001
  When the client sends a DELETE request to "/api/testcases/2001"
  Then the response status code should be 204
  And subsequent GET request for the same ID should return 404

  Scenario: Delete non-existing test case
  Given a valid auth token
  When the client sends DELETE request for non-existing ID
  Then the response status code should be 404


  
  Scenario: Send malformed JSON
  Given a valid auth token
  And malformed JSON payload
  When the client sends a POST request
  Then the response status code should be 400
  And error code should indicate "INVALID_JSON_FORMAT"

  Scenario: User attempts to access project not assigned
  Given a valid token for User A
  And project belongs to User B
  When User A sends GET request to that project
  Then the response status code should be 403
  And the event should be logged.

 


  Scenario: Database connection failure
  Given the database service is down
  When the client sends GET request
  Then the response status code should be 503
  And the error message should indicate "Service Unavailable"
  And no sensitive internal stack trace should be exposed

  Scenario: Unexpected server exception
  Given server throws runtime exception
  When client sends valid request
  Then response status code should be 500
  And response body should contain generic error message


  Scenario: Exceed allowed requests per minute
  Given rate limit is 100 requests per minute
  When client sends 101 requests within one minute
  Then the 101st request should return status 429
  And response header should include "Retry-After".



  Scenario: Attempt SQL injection in query parameter
  Given a valid auth token
  When client sends GET request with id parameter "' OR 1=1 --"
  Then the response status code should be 400
  And the system should sanitize input
  And no unintended data should be returned.

  Scenario: Attempt XSS script injection
  Given a valid auth token
  When client sends POST request with title "<script>alert(1)</script>"
  Then response status code should be 400
  And script should not be executed or persisted.

  Scenario: Non-admin user attempts to delete project
  Given a valid token with role "User"
  When client sends DELETE request to "/api/projects/101"
  Then response status code should be 403
  And error message should indicate insufficient privileges


  Scenario: Validate project response structure
  Given a valid auth token
  When client sends GET request to "/api/projects/101"
  Then the response should match JSON schema:
    - id (integer)
    - name (string)
    - created_at (ISO datetime)
    - status (enum: Active, Archived).



  Scenario: Validate data consistency
  Given a valid auth token
  When client creates a new test case
  And client retrieves the same test case by ID
  Then all fields in GET response should match POST response
  And created timestamp should remain unchanged.

  Scenario: Handle concurrent updates
  Given two users retrieve the same test case
  When User A updates priority to "High"
  And User B updates priority to "Low"
  Then the system should handle version conflict
  And one update should fail with status 409.


  Scenario: Create test case with extremely large payload
   Given a valid auth token
   And request body exceeds maximum allowed size
   When client sends POST request
   Then response status code should be 413
   And error message should indicate payload too large


   Scenario: Validate pagination boundary
    Given valid auth token
    When client sends GET request with page=1&limit=1000
    Then response should return maximum allowed records
    And should not exceed configured limit



  


  

