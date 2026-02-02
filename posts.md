---
layout: page
title: Newsletter
permalink: /posts/
---

{% for post in site.posts %}
### [{{ post.title }}]({{ post.url | relative_url }})
*{{ post.date | date: "%B %d, %y" }}*

{{ post.excerpt | strip_html | truncatewords: 30 }}

---
{% endfor %}
