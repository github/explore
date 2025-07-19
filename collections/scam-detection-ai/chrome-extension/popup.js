document.addEventListener('DOMContentLoaded', () => {
    chrome.storage.local.get(['analysisResult'], (result) => {
        if (result.analysisResult) {
            document.getElementById('result').innerHTML = result.analysisResult;
            chrome.storage.local.remove(['analysisResult']);
        }
    });
});

document.getElementById('analyzeButton').addEventListener('click', () => {
    const text = document.getElementById('textToAnalyze').value;
    fetch('http://localhost:5000/analyze', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `message_text=${encodeURIComponent(text)}`
    })
    .then(response => response.text())
    .then(data => {
        document.getElementById('result').innerHTML = data;
    })
    .catch(error => {
        console.error('Error:', error);
        document.getElementById('result').innerText = 'Error analyzing text.';
    });
});
