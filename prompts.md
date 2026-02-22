## Login Module Prompt – Version 1

You are a senior QA automation engineer working on a web-based test management platform.

Generate comprehensive test scenarios for the Login module.

Coverage requirements:
- Valid login
- Invalid credentials
- Forgot password
- Session expiry
- Brute-force lockout protection

Include:
- Positive test cases
- Negative test cases
- Boundary cases
- Security scenarios

Output format: Gherkin.
Each scenario must include:
- Scenario Title
- Given
- When
- Then

Do not skip edge cases. Make them production-ready.

### Reflection – Login Module

Initial output included valid and invalid scenarios but lacked deep boundary testing and specific security edge cases like multiple failed attempts over time.

To improve output quality, I explicitly added “boundary cases” and “security scenarios” in the refined prompt, which resulted in better coverage including brute-force lockout and session expiry validation.


## Dashboard Module Prompt – Version 1

You are a senior QA automation engineer working on a web-based test management platform.

Generate comprehensive test scenarios for the Dashboard module.

Coverage requirements:
- Widget loading
- Data accuracy in widgets
- Filter behavior
- Sort behavior
- Responsive layout
- Permission-based visibility

Include:
- Positive test cases
- Negative test cases
- Boundary conditions
- Security considerations (role-based access)

Output format: Gherkin.
Each scenario must include:
- Scenario Title
- Given
- When
- Then

Ensure test cases cover UI behavior, data validation, and access control logic.
Make them production-ready.

### Reflection – Dashboard Module

Initial output focused mainly on widget loading and filters.
It lacked deeper role-based validation and negative permission scenarios.

Refined the prompt to explicitly include access-control logic and boundary conditions, resulting in improved coverage for restricted roles and filter edge cases.



## REST API Module Prompt – Version 1

You are a senior QA automation engineer testing a REST API for a web-based test management system.

Generate comprehensive API test scenarios covering:

- Auth token validation
- CRUD operations (Create, Read, Update, Delete)
- 4xx error handling
- 5xx error handling
- Rate limiting
- Schema validation

Include:
- Positive API test cases
- Negative test cases
- Boundary conditions
- Security test cases (authorization, injection attacks)
- Data consistency validation

Output format: Gherkin.
Each scenario must include:
- Scenario Title
- Given
- When
- Then

Ensure the cases are production-grade and reflect real-world API validation strategies.