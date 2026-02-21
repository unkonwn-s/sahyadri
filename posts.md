---
layout: page
title: Newsletter
permalink: /posts/
---

Welcome to the **Sahyadri School Newsletter.**

<div class="posts-list">
  {% assign grouped_posts = site.posts | group_by: "category" %}

  {% for group in grouped_posts %}
    <div class="term-section" style="margin-top: 50px;">
      {% comment %} --- Category Heading (Larger) --- {% endcomment %}
      <h2 class="term-title" style="font-size: 2.5em; border-bottom: 2px solid #008AFF; padding-bottom: 10px; margin-bottom: 25px; color: #404040;">
        {{ group.name | default: "General Updates" }}
      </h2>

      {% for post in group.items %}
        <article class="post-preview" style="margin-bottom: 40px;">
          <a href="{{ post.url | relative_url }}">
            {% comment %} --- Article Title (Smaller than Category) --- {% endcomment %}
            <h3 class="post-title" style="font-size: 1.8em; margin-bottom: 5px;">{{ post.title }}</h3>
            {% if post.subtitle %}
              <h4 class="post-subtitle" style="font-weight: normal; color: #777; font-size: 1.1em;">{{ post.subtitle }}</h4>
            {% endif %}
          </a>

          <p class="post-meta" style="font-size: 0.9em; color: #999; margin-bottom: 15px;">
            Posted on {{ post.date | date: site.date_format }}
          </p>

          <div class="post-entry-container" style="display: flex; gap: 20px; align-items: flex-start;">
            {% if post.image %}
              <div class="post-image" style="flex: 0 0 200px;">
                <a href="{{ post.url | relative_url }}">
                  <img src="{{ post.image | relative_url }}" alt="{{ post.title }}" style="width: 100%; border-radius: 4px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
                </a>
              </div>
            {% endif %}
            
            <div class="post-entry">
              {{ post.excerpt | strip_html | truncatewords: 30 }}
              <a href="{{ post.url | relative_url }}" class="post-read-more" style="color: #008AFF; font-weight: bold;">[Read&nbsp;More]</a>
            </div>
          </div>
        </article>
      {% endfor %}
    </div>
  {% else %}
    <p>No newsletters found. Check back soon!</p>
  {% endfor %}
</div>
