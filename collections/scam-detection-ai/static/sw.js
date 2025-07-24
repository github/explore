const CACHE_NAME = 'scam-detection-ai-cache-v1';
const urlsToCache = [
  '/',
  '/static/styles.css', // Assuming you'll have a stylesheet
  '/static/app.js'      // Assuming you'll have some javascript
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => {
        console.log('Opened cache');
        return cache.addAll(urlsToCache);
      })
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        if (response) {
          return response;
        }
        return fetch(event.request);
      }
    )
  );
});
