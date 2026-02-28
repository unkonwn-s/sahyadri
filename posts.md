---
layout: page
title: Newsletter
permalink: /posts/
---

<div class="newsletter-container">
  
  <aside class="toc-sidebar">
    <nav class="toc-card">
      <h2 class="toc-title">Categories</h2>
      <ul class="toc-list">
        {% assign grouped_posts = site.posts | group_by: "category" %}
        {% for group in grouped_posts %}
          {% assign category_id = group.name | slugify | default: "general-updates" %}
          <li><a href="#{{ category_id }}">{{ group.name | default: "General Updates" }}</a></li>
        {% endfor %}
      </ul>
    </nav>
  </aside>

  <div class="posts-list">
    {% for group in grouped_posts %}
      {% assign category_id = group.name | slugify | default: "general-updates" %}
      
      <section class="term-section" id="{{ category_id }}">
        <h2 class="category-heading">
          {{ group.name | default: "General Updates" }}
        </h2>

        {% for post in group.items %}
          <article class="post-preview">
            <a href="{{ post.url | relative_url }}">
              <h3 class="post-title">{{ post.title }}</h3>
              {% if post.subtitle %}
                <h4 class="post-subtitle">{{ post.subtitle }}</h4>
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
                {{ post.excerpt | strip_html | truncatewords: 30 }}
                <a href="{{ post.url | relative_url }}" class="post-read-more">[Read&nbsp;More]</a>
              </div>
            </div>
          </article>
        {% endfor %}
        
        <div class="back-to-top">
           <a href="#top">↑ Back to top</a>
        </div>
      </section>
    {% else %}
      <p>No newsletters found. Check back soon!</p>
    {% endfor %}
  </div>
</div>
