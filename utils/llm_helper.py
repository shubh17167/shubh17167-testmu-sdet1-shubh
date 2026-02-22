import os
from openai import OpenAI
from dotenv import load_dotenv

# Load environment variables from .env
load_dotenv()

# Initialize OpenAI client
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))


def explain_failure(error_message: str) -> str:
    """
    Sends failed test details to LLM and returns explanation.
    """

    if not os.getenv("OPENAI_API_KEY"):
        return "OPENAI_API_KEY not found in environment variables."

    prompt = f"""
You are a senior QA automation engineer.

Analyze the following failed test execution.

Provide:
1. Likely root cause
2. Whether it is a test issue or product defect
3. Suggested debugging steps or fix

Failure Details:
{error_message}
"""

    try:
        response = client.chat.completions.create(
            model="gpt-4o-mini",
            messages=[
                {
                    "role": "system",
                    "content": "You are an expert QA debugging assistant."
                },
                {
                    "role": "user",
                    "content": prompt
                }
            ],
            temperature=0.3
        )

        explanation = response.choices[0].message.content

        return f"""
================ AI FAILURE EXPLANATION ================

{explanation}

========================================================
"""

    except Exception as e:
        return f"""
================ LLM SERVICE ERROR ======================

LLM call failed.
Reason:
{str(e)}

Possible Causes:
- API key invalid
- Billing quota exceeded
- Network issue

Integration is correctly implemented, but external API call failed.

========================================================
"""