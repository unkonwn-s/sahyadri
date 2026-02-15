---
layout: page
title: Newsletter
permalink: /posts/
---

Welcome to the Sahyadri School Newsletter

{% for post in site.posts %}
  <div class="post-preview">
    <a href="{{ post.url | relative_url }}">
      <h2 class="post-title">{{ post.title }}</h2>
      {% if post.subtitle %}
        <h3 class="post-subtitle">{{ post.subtitle }}</h3>
      {% endif %}
    </a>
    <p class="post-meta">
      Posted on {{ post.date | date: site.date_format }}
    </p>
    <div class="post-entry">
      {{ post.excerpt | strip_html | truncatewords: 50 }}
      <a href="{{ post.url | relative_url }}" class="post-read-more">[Read&nbsp;More]</a>
    </div>
  </div>
  <hr>
{% endfor %}
