chrome.runtime.onInstalled.addListener(() => {
  chrome.contextMenus.create({
    id: "analyzeText",
    title: "Analyze for Scams",
    contexts: ["selection"]
  });
});

chrome.contextMenus.onClicked.addListener((info, tab) => {
  if (info.menuItemId === "analyzeText") {
    fetch('http://localhost:5000/analyze', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `message_text=${encodeURIComponent(info.selectionText)}`
    })
    .then(response => response.text())
    .then(data => {
        chrome.storage.local.set({ analysisResult: data });
    })
    .catch(error => {
        console.error('Error:', error);
        chrome.storage.local.set({ analysisResult: 'Error analyzing text.' });
    });
  }
});
