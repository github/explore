import unittest
from email_analyzer import analyze_email

class TestEmailAnalyzer(unittest.TestCase):

    def test_scam_email(self):
        scam_email = """
        From: Urgent Winner <winner@example.com>
        Subject: Action Required: You have won a prize!

        Dear customer,

        You have won a lottery! To claim your prize, please send your bank account details and a payment of $50 for processing fees.
        Click this link to proceed: http://fake-prize.com/claim

        This is a limited time offer, it will expire in 24 hours.
        """
        analysis = analyze_email(scam_email)
        self.assertEqual(analysis['urgency'], 1)
        self.assertEqual(analysis['generic_greeting'], 1)
        self.assertEqual(analysis['suspicious_links'], 1)
        self.assertEqual(analysis['payment_requests'], 1)

    def test_legitimate_email(self):
        legitimate_email = """
        From: John Doe <john.doe@work.com>
        Subject: Project Update

        Hi Team,

        Here is the update on our project. I've attached the weekly report.
        Let's discuss it in our meeting tomorrow.

        Best,
        John
        """
        analysis = analyze_email(legitimate_email)
        self.assertEqual(analysis['urgency'], 0)
        self.assertEqual(analysis['generic_greeting'], 0)
        self.assertEqual(analysis['suspicious_links'], 0)
        self.assertEqual(analysis['payment_requests'], 0)

if __name__ == '__main__':
    unittest.main()
