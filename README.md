# 🚀 AI-Native Test Automation Framework
## REST API + UI Validation with Real LLM Failure Analysis

---

## 📌 Overview

This repository demonstrates an AI-native approach to reducing regression testing effort by integrating Large Language Models (LLMs) directly into the test execution workflow.

The framework covers:

- Login Module  
- Dashboard Module  
- REST API Module  

Beyond structured test design, this project integrates real-time LLM-based failure analysis to assist debugging during test execution.

---

## 🧠 Key Objectives

- Generate comprehensive Gherkin-based test scenarios using LLMs  
- Implement structured UI and API test validation  
- Integrate real OpenAI API calls into failure handling  
- Ensure secure environment configuration  
- Maintain transparent AI usage logging  

---

## 🛠 Tech Stack

- **Language:** Python 3.10  
- **Framework:** Pytest  
- **Automation:** Playwright (setup ready)  
- **AI Integration:** OpenAI API (real call, no mocking)  
- **Environment Management:** python-dotenv  

---

## 📁 Project Structure

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
├── .gitignore
```

> Note: `.env` is excluded via `.gitignore`.

---

# 📌 Test Coverage

## 1️⃣ Login Module

- Valid / invalid login  
- Brute-force protection  
- CAPTCHA behavior  
- Session expiry  
- HTTPS enforcement  
- Password masking  

---

## 2️⃣ Dashboard Module

- Widget loading & async handling  
- Data validation  
- Filter & sort logic  
- Responsive behavior  
- Permission-based visibility  

---

## 3️⃣ REST API Module

- JWT authentication (valid, missing, expired, tampered)  
- CRUD operations  
- 4xx / 5xx handling  
- Rate limiting (429 + Retry-After header)  
- Schema validation  
- Concurrency conflict handling (409)  
- SQL injection & XSS protection  
- Large payload handling (413)  
- Pagination boundary validation  

---

# 🤖 LLM Integration – Failure Explainer

When a test fails:

1. Failure details are captured  
2. The error is sent to OpenAI API  
3. The LLM analyzes the failure  
4. A structured explanation is returned  
5. The explanation is printed in test output  

### Integration Location
```
utils/llm_helper.py
```

### Core Function
```python
explain_failure(error_message: str) -> str
```

If API quota is exceeded, the framework gracefully handles the external API failure without breaking test execution.

---

# 🔍 AI Usage Transparency

All AI prompts and outputs are logged in:

- `ai-usage-log.md`  
- `prompts.md`  

No post-processing cleanup was performed, ensuring transparency.

---

# 🔐 Security Considerations

- `.env` is excluded via `.gitignore`  
- API keys are not committed  
- No secrets are logged  
- LLM API errors are gracefully handled  
- Real API integration (no mocking used)  

---

# 🚀 How To Run

## 1️⃣ Install Dependencies

```bash
pip install -r requirements.txt
playwright install
```

## 2️⃣ Configure Environment

Create a `.env` file:

```env
OPENAI_API_KEY=your_key_here
```

## 3️⃣ Run Tests

```bash
pytest
```

If a test fails, the AI Failure Explainer triggers automatically.

---

# 🎯 Why This Reduces Regression Effort

AI assists QA by:

- Generating structured test scenarios  
- Identifying missing edge cases  
- Explaining failures instantly  
- Distinguishing product bugs from test issues  
- Reducing manual log analysis  

This shifts QA from manual triage to AI-assisted diagnostics.

---

# 🔮 Future Enhancements

- Attach Playwright screenshots to LLM prompts  
- Auto-classify failure types (bug vs flaky vs infra)  
- Generate Jira-ready bug reports  
- CI pipeline integration  
- Cluster recurring failures using embeddings  

---

# ✅ Conclusion

This project demonstrates:

- Structured test design  
- Security-focused QA thinking  
- Boundary & edge-case validation  
- Real LLM integration within test workflow  
- Transparent AI logging  
- Robust error handling  

The implementation aligns with modern AI-native quality engineering principles.
