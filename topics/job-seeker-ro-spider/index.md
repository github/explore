---
display_name: Peviitor Job Spider
short_description: Web scrapers that collect job titles and application links from Romanian company career pages and push them to peviitor.ro.
topic: job-seeker-ro-spider
related: web-scraping, data-extraction, automation, github-actions, open-source, etl
---

**Peviitor Job Spider** is a collection of web scrapers that extract job titles and application links from Romanian company career pages and index them in [peviitor.ro](https://peviitor.ro) — a Romanian job search engine.

Each scraper targets one company, validates legal identity through the ANAF public API, extracts job listings from HTML or JSON sources, and pushes structured data to Apache Solr. The ecosystem includes Node.js (ESM, cheerio) and Python implementations, all deployed via GitHub Actions on a cron schedule.

Part of the peviitor.ro open-source community — a crowd-sourced job aggregator that keeps Romania's tech job market up to date.

Want to contribute? Whether you prefer Java, JavaScript, Rust, Go, Nim, R, or any other language — you're welcome to write your own scraper and help grow peviitor.ro!
