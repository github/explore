from flask import Flask, render_template, request
from email_analyzer import analyze_email
from email_fetcher import fetch_emails

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/analyze', methods=['POST'])
def analyze():
    if 'email_text' in request.form:
        email_text = request.form['email_text']
        analysis = analyze_email(email_text)
        total_score = sum(analysis.values())
        is_scam = total_score >= 3
        return render_template('result.html', analysis=analysis, is_scam=is_scam)

    elif 'fetch_emails' in request.form:
        username = request.form['username']
        password = request.form['password']
        emails = fetch_emails(username, password)

        analyzed_emails = []
        if emails:
            for email_message in emails:
                body = ""
                if email_message.is_multipart():
                    for part in email_message.walk():
                        if part.get_content_type() == "text/plain":
                            body = part.get_payload(decode=True).decode()
                            break
                else:
                    body = email_message.get_payload(decode=True).decode()

                analysis = analyze_email(body)
                total_score = sum(analysis.values())
                is_scam = total_score >= 3

                subject, _ = email.header.decode_header(email_message["Subject"])[0]
                if isinstance(subject, bytes):
                    subject = subject.decode()

                analyzed_emails.append({
                    "subject": subject,
                    "from": email_message['From'],
                    "analysis": analysis,
                    "is_scam": is_scam
                })
        return render_template('results_list.html', emails=analyzed_emails)

    return "Invalid request", 400

if __name__ == '__main__':
    app.run(debug=True)
