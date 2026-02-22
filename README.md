📌 Overview

This repository demonstrates an AI-native approach to reducing regression testing effort across:

Login Module

Dashboard Module

REST API Module

The objective was not only to generate test cases using LLMs, but to integrate AI directly into the test execution workflow to assist in failure analysis.

This project reflects structured test design, security awareness, boundary validation, and real LLM integration.

🧠 Task 1 — Project Setup & Scaffold
🔹 Tech Stack Chosen

Language: Python 3.10

Framework: Pytest

Automation: Playwright (setup ready)

AI Integration: OpenAI API (real call)

Environment Handling: python-dotenv

## 📁 Folder Structure

```text
testmu-sdet1-shubh/
│
├── tests/
│   ├── ui/
│   ├── api/
│
├── utils/
│   └── llm_helper.py
│
├── prompts.md
├── ai-usage-log.md
├── README.md
├── .env (excluded from Git)
├── .gitignore
```
The structure separates:

UI layer

API layer

Utility layer (LLM integration)

Documentation

This ensures maintainability and clarity.

📝 Task 2 — Prompt Engineering for Test Generation

LLMs were used to generate comprehensive Gherkin test scenarios for:

1️⃣ Login Module

Coverage includes:

Valid / invalid login

Brute-force protection

CAPTCHA

Session expiry

Security hardening (HTTPS enforcement, password masking)

2️⃣ Dashboard Module

Coverage includes:

Widget loading and async handling

Data validation

Filter & sort logic

Responsive behavior

Permission-based visibility

XSS prevention

Performance SLA

3️⃣ REST API Module

Coverage includes:

Auth token validation (valid, missing, expired, tampered)

CRUD operations

4xx / 5xx handling

Rate limiting (429 + Retry-After header)

Schema validation

Concurrency (409 conflict)

Security injection attempts

Boundary payload handling

Pagination validation

Each prompt iteration and reflection is documented in prompts.md.

🤖 Task 3 — LLM Integration (Failure Explainer)
✅ Option Chosen: Failure Explainer

When a test fails:

Failure details are captured.

The error is sent to OpenAI API.

LLM analyzes the failure.

A human-readable explanation is returned.

The explanation is printed in test output.

🔹 Integration Location

utils/llm_helper.py

🔹 Key Function
explain_failure(error_message)
🔹 Example Console Output
================ AI FAILURE EXPLANATION ================

Root Cause:
The assertion failed because expected value did not match actual result.

Classification:
Likely test assertion issue.

Suggested Fix:
Update assertion or validate expected value.

========================================================

If API quota is exceeded, the framework gracefully handles the external API error without crashing the test execution.

This proves:

Real LLM API call is implemented

Error handling is robust

No mocking was used

🏗 Why This Approach Reduces Regression Effort

AI can reduce manual QA effort by:

Generating structured test scenarios

Identifying missing edge cases

Explaining failures instantly

Differentiating potential product bug vs test issue

Assisting debugging without manual log analysis

This shifts QA from manual failure triage to AI-assisted failure insight.

🔒 Security Considerations

.env is excluded via .gitignore

API key is not committed

Failure logs do not expose secrets

LLM errors are gracefully handled

📈 With More Time, I Would Extend This To:

Capture Playwright screenshots and attach to LLM prompts

Auto-classify failures (bug vs flaky vs environment issue)

Generate Jira-ready bug summaries automatically

Integrate into CI pipeline

Track recurring failure patterns using LLM clustering

📋 How to Run
1️⃣ Install dependencies
pip install -r requirements.txt
playwright install
2️⃣ Add OpenAI API Key

Create .env file:

OPENAI_API_KEY=your_key_here
3️⃣ Run tests
pytest

If a test fails, LLM Failure Explainer will trigger automatically.

📘 AI Usage Transparency

All AI usage, prompts, and outputs are logged in:

ai-usage-log.md

Prompts are documented exactly as written in:

prompts.md

No post-generation cleanup was done to maintain transparency.

🎯 Conclusion

This submission demonstrates:

Structured test design

Security-focused QA thinking

Boundary & edge case awareness

API contract validation

Real LLM integration into test workflow

Transparent AI usage logging

The approach aligns with AI-native quality engineering principles.
