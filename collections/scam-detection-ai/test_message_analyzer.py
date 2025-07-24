import unittest
from message_analyzer import analyze_message

class TestMessageAnalyzer(unittest.TestCase):

    def test_scam_message(self):
        scam_message = "Congratulations! You've won a prize. Click http://bit.ly/scam to claim."
        analysis = analyze_message(scam_message)
        self.assertEqual(analysis['shortened_urls'], 1)
        self.assertEqual(analysis['prize_offers'], 1)

    def test_legitimate_message(self):
        legitimate_message = "Your appointment is confirmed for 3 PM tomorrow."
        analysis = analyze_message(legitimate_message)
        self.assertEqual(analysis['shortened_urls'], 0)
        self.assertEqual(analysis['prize_offers'], 0)
        self.assertEqual(analysis['urgent_requests'], 0)

if __name__ == '__main__':
    unittest.main()
