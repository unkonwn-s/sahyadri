---
layout: page
title: Newsletter
permalink: /posts/
---

<div class="posts-list">
  {% for post in paginator.posts %}
    <article class="post-preview">
      <a href="{{ post.url | relative_url }}">
        <h2 class="post-title">{{ post.title }}</h2>
      </a>
      <p class="post-meta">Posted on {{ post.date | date: site.date_format }}</p>
      <div class="post-entry">
        {{ post.excerpt | strip_html | truncatewords: 50 }}
      </div>
    </article>
    <hr>
  {% endfor %}
</div>

<div class="pagination">
  {% if paginator.previous_page %}
    <a href="{{ paginator.previous_page_path | relative_url }}">&laquo; Newer Posts</a>
  {% endif %}

  <span>Page {{ paginator.page }} of {{ paginator.total_pages }}</span>

  {% if paginator.next_page %}
    <a href="{{ paginator.next_page_path | relative_url }}">Older Posts &raquo;</a>
  {% endif %}
</div>
