---
layout: page
title: Newsletter
permalink: /posts/
---

Welcome to the **Sahyadri School Newsletter.** 

---

<div class="posts-list">
  {% for post in site.posts %}
    <article class="post-preview">
      <a href="{{ post.url | relative_url }}">
        <h2 class="post-title">{{ post.title }}</h2>
        {% if post.subtitle %}
          <h3 class="post-subtitle">{{ post.subtitle }}</h3>
        {% endif %}
      </a>

      <p class="post-meta">
        Posted on {{ post.date | date: site.date_format }}
      </p>

      <div class="post-entry-container">
        {% if post.image %}
          <div class="post-image">
            <a href="{{ post.url | relative_url }}">
              <img src="{{ post.image | relative_url }}" alt="{{ post.title }}">
            </a>
          </div>
        {% endif %}
        
        <div class="post-entry">
          {{ post.excerpt | strip_html | truncatewords: 50 }}
          <a href="{{ post.url | relative_url }}" class="post-read-more">[Read&nbsp;More]</a>
        </div>
      </div>
    </article>
    <hr>
  {% else %}
    <p>No posts found. Check back soon!</p>
  {% endfor %}
</div>
