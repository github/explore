import imaplib
import email
from email.header import decode_header

def fetch_emails(username, password, server="imap.gmail.com"):
    """
    Fetches emails from an IMAP server.

    Args:
        username: The email account username.
        password: The email account password.
        server: The IMAP server address.

    Returns:
        A list of email messages.
    """
    try:
        # connect to the server
        mail = imaplib.IMAP4_SSL(server)
        # login
        mail.login(username, password)
        # select the inbox
        mail.select("inbox")

        # search for all emails
        status, messages = mail.search(None, "ALL")
        email_ids = messages[0].split()

        emails = []
        for email_id in email_ids[-5:]:  # Fetch last 5 emails for demonstration
            status, msg_data = mail.fetch(email_id, "(RFC822)")
            for response_part in msg_data:
                if isinstance(response_part, tuple):
                    msg = email.message_from_bytes(response_part[1])
                    emails.append(msg)

        mail.logout()
        return emails

    except imaplib.IMAP4.error as e:
        print(f"IMAP Error: {e}")
        return []

if __name__ == '__main__':
    # This is a placeholder for a secure way to get credentials
    EMAIL_USERNAME = "your_email@gmail.com"
    EMAIL_PASSWORD = "your_app_password"

    emails = fetch_emails(EMAIL_USERNAME, EMAIL_PASSWORD)
    if emails:
        for email_message in emails:
            subject, encoding = decode_header(email_message["Subject"])[0]
            if isinstance(subject, bytes):
                subject = subject.decode(encoding if encoding else "utf-8")

            print("="*50)
            print(f"Subject: {subject}")
            print(f"From: {email_message['From']}")
            print(f"To: {email_message['To']}")

            if email_message.is_multipart():
                for part in email_message.walk():
                    content_type = part.get_content_type()
                    content_disposition = str(part.get("Content-Disposition"))
                    try:
                        body = part.get_payload(decode=True).decode()
                        if "attachment" not in content_disposition:
                            print("\n--- Body ---\n", body)
                    except:
                        pass
            else:
                body = email_message.get_payload(decode=True).decode()
                print("\n--- Body ---\n", body)
            print("="*50 + "\n")
    else:
        print("Could not fetch emails. Please check your credentials and IMAP settings.")
