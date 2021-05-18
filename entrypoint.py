#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import json
from random import choice
from urllib.request import urlopen, Request
from urllib.parse import urlencode
from datetime import datetime

from atoma import parse_rss_bytes

from utils import u, html_unescape, filter_json_index_by_year


json_index_content = {}
facebook_page_id = os.environ.get('FACEBOOK_PAGE_ID')
facebook_access_token = os.environ.get('FACEBOOK_ACCESS_TOKEN')
facebook_api_end = 'https://graph.facebook.com/{0}/feed'.format(facebook_page_id)
feed_url = os.environ.get('FEED_URL')
feed_data = parse_rss_bytes(urlopen(feed_url).read())

current_timestamp = int(datetime.now().strftime('%Y%m%d%H%M%S'))
current_hour = int(datetime.now().strftime('%H'))

if current_hour not in [9, 13, 15, 22]:
    print('Script wasnt called in a recommended hour. Aborting.')
    sys.exit(0)

for post in feed_data.items:
    post_timestamp = post.pub_date.strftime('%Y%m%d%H%M%S')
    json_index_content[post_timestamp] = {
        'title': post.title,
        'url': post.guid,
        'date': post.pub_date
    }

json_index_filtered = filter_json_index_by_year(json_index_content)

if not json_index_filtered:
    print('There are no posts to publish. Aborting.')
    sys.exit(0)

random_post_id = choice(list(json_index_filtered.keys()))
random_post_title = json_index_filtered[random_post_id]['title']
random_post_title = u(html_unescape(random_post_title))
random_post_url = u('{0}#{1}'.format(
    json_index_filtered[random_post_id]['url'],
    current_timestamp))

facebook_api_data = {'message': random_post_title,
                     'link': random_post_url,
                     'access_token': facebook_access_token}

http_request = Request(url=facebook_api_end, method='POST',
                       data=urlencode(facebook_api_data).encode())

count = 0
while count < 6:
    try:
        result = json.loads(str(urlopen(http_request).read(), 'utf-8'))
    except Exception as e:
        print('There was an error publishing: {0}'.format(e))
        count += 1
        continue

    if 'error' in result:
        count += 1
        continue

    print('Successfully published!: {0}'.format(random_post_url))
    break
