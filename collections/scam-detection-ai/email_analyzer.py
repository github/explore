import re

def analyze_email(email_text):
    """
    Analyzes an email for potential scam indicators.

    Args:
        email_text: The full text of the email.

    Returns:
        A dictionary containing the analysis results.
    """
    scam_indicators = {
        "urgency": 0,
        "generic_greeting": 0,
        "suspicious_links": 0,
        "unusual_sender": 0,
        "payment_requests": 0,
        "attachments": 0
    }

    # Urgency keywords
    urgency_keywords = ["urgent", "immediate", "action required", "limited time", "expire"]
    for keyword in urgency_keywords:
        if re.search(r'\b' + keyword + r'\b', email_text, re.IGNORECASE):
            scam_indicators["urgency"] = 1
            break

    # Generic greeting
    generic_greetings = ["dear customer", "dear user", "sir/madam"]
    for greeting in generic_greetings:
        if email_text.lower().startswith(greeting):
            scam_indicators["generic_greeting"] = 1
            break

    # Suspicious links (basic check for non-standard URLs)
    if re.search(r'http[s]?://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}/[a-zA-Z0-9_.-]+', email_text):
        scam_indicators["suspicious_links"] = 1

    # Unusual sender (very basic check)
    if "From:" in email_text:
        from_line = email_text.split("From:")[1].split("\n")[0]
        if re.search(r'<.*@.*>', from_line) and not re.search(r'<.*@.*\..*>', from_line):
            scam_indicators["unusual_sender"] = 1

    # Payment requests
    payment_keywords = ["payment", "invoice", "wire transfer", "bank account", "credit card"]
    for keyword in payment_keywords:
        if re.search(r'\b' + keyword + r'\b', email_text, re.IGNORECASE):
            scam_indicators["payment_requests"] = 1
            break

    # Attachments
    if "Content-Disposition: attachment" in email_text:
        scam_indicators["attachments"] = 1

    return scam_indicators

if __name__ == '__main__':
    sample_email = """
    From: Suspicious Sender <suspicious@example.com>
    Subject: Urgent Action Required: Your Account Will Be Deactivated

    Dear user,

    We have detected suspicious activity on your account. For your security, we have temporarily suspended your account.
    To reactivate your account, you must verify your identity by clicking the link below and updating your payment information.

    http://suspicious-link.com/verify

    Failure to do so within 24 hours will result in permanent account deactivation.

    Thank you for your cooperation.

    Sincerely,
    The Security Team
    """

    analysis = analyze_email(sample_email)
    print(analysis)

    total_score = sum(analysis.values())
    if total_score >= 3:
        print("\nThis email is likely a scam!")
    else:
        print("\nThis email seems legitimate.")
