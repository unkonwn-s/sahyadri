---
layout: page
title:
permalink: /posts/
---
## Sahyadri School Newsletter
<style>
  .post-read-more {
    color: #404040; /* Same as your text-col in _config.yml */
    font-weight: none;
    text-decoration: none;
    transition: color 0.2s ease;
  }
  .post-read-more:hover {
    color: #008AFF; /* Same as your link-col in _config.yml */
    text-decoration: underline;
  }
</style>

<div class="posts-list">
  {% assign grouped_posts = site.posts | group_by: "category" %}

  {% for group in grouped_posts %}
    <div class="term-section" style="margin-top: 50px;">
      <p class="term-title" style="font-size: 2.5em; border-bottom: 2px solid #735362; padding-bottom: 10px; margin-bottom: 25px; color: #404040;">
        {{ group.name | default: "General Updates" }}
      </p>

      {% for post in group.items %}
        <article class="post-preview" style="margin-bottom: 40px;">
          <a href="{{ post.url | relative_url }}">
            <p class="post-title" style="font-size: 1.8em; margin-bottom: 5px;">{{ post.title }}</p>
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
            
            <div class="post-entry" style="color: #404040;">
              {{ post.excerpt | strip_html | truncatewords: 30 }}
              <a href="{{ post.url | relative_url }}" class="post-read-more">[Read&nbsp;More]</a>
            </div>
          </div>
        </article>
        <hr style="border: 0; border-top: 1px solid #735362; margin: 20px 0;">
      {% endfor %}
    </div>
  {% else %}
    <p>No newsletters found. Check back soon!</p>
  {% endfor %}
</div>
