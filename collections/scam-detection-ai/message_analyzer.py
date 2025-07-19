import re

def analyze_message(message_text):
    """
    Analyzes an SMS or other short message for potential scam indicators.

    Args:
        message_text: The full text of the message.

    Returns:
        A dictionary containing the analysis results.
    """
    scam_indicators = {
        "shortened_urls": 0,
        "unusual_sender": 0,
        "urgent_requests": 0,
        "prize_offers": 0
    }

    # Check for shortened URLs
    shortened_url_patterns = [r'bit\.ly', r't\.co', r'goo\.gl', r'tinyurl\.com']
    for pattern in shortened_url_patterns:
        if re.search(pattern, message_text):
            scam_indicators["shortened_urls"] = 1
            break

    # Check for unusual sender (e.g., non-numeric sender ID)
    # This is a very basic check and would need to be improved.
    sender_match = re.search(r'From:\s*(\S+)', message_text, re.IGNORECASE)
    if sender_match:
        sender = sender_match.group(1)
        if not sender.isdigit() and len(sender) > 10:
            scam_indicators["unusual_sender"] = 1

    # Check for urgent requests
    urgent_keywords = ["urgent", "verify", "confirm", "login", "account"]
    for keyword in urgent_keywords:
        if re.search(r'\b' + keyword + r'\b', message_text, re.IGNORECASE):
            scam_indicators["urgent_requests"] = 1
            break

    # Check for prize offers
    prize_keywords = ["congratulations", "winner", "prize", "claim", "won"]
    for keyword in prize_keywords:
        if re.search(r'\b' + keyword + r'\b', message_text, re.IGNORECASE):
            scam_indicators["prize_offers"] = 1
            break

    return scam_indicators

if __name__ == '__main__':
    sample_message = """
    From: 555-123-4567
    Congratulations! You've won a $1000 gift card. Click here to claim: http://bit.ly/fake-prize
    """
    analysis = analyze_message(sample_message)
    print(analysis)

    total_score = sum(analysis.values())
    if total_score >= 2:
        print("\nThis message is likely a scam!")
    else:
        print("\nThis message seems legitimate.")
