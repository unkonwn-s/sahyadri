---
# FILE: index.md
# PURPOSE: Homepage. Uses 'page' layout — welcome text, plus a "Latest
# from the Newsletter" teaser showing the single most recent post
# (reuses posts.md's .post-preview-card markup for visual consistency).
# NOTE: this page used to mention an unused _layouts/home.html (a
# generic post-feed/pagination template from the original theme, whose
# field names never matched how content is actually authored here, and
# which depended on the jekyll-paginate plugin the Gemfile excludes).
# That file was deleted as dead code. If a paginated post-feed homepage
# is ever wanted, it would need to be built fresh against this site's
# real front matter fields (image/image_id, subtitle/subtitle2, etc.)
# rather than resurrected from the old theme file.
layout: page
title: Sahyadri Connect
subtitle: 
---



A window into life at Sahyadri School, a space to keep parents and friends connected with the rhythms, reflections, and relationships that shape our everyday experience here. You will find monthly newsletters, glimpses of life on campus, upcoming events, and selected talks and videos from Krishnamurti. We hope this helps foster a deeper understanding of the values that guide the school and invites a shared inquiry into learning, living, and growing together.

{% comment %}
  Homepage newsletter teaser: shows the single most recent Newsletter
  post (site.posts is sorted newest-first by Jekyll by default). Reuses
  the exact .post-preview-card markup/classes from posts.md so this
  renders identically to how the post appears there -- no new CSS
  needed. Deliberately simplified vs. posts.md's own card: skips the
  byline-to-profile-link matching (which needs a known_profile_slugs
  lookup built from site.profiles) since this is a single teaser, not
  a full listing -- the byline shows as plain text here instead.
{% endcomment %}
{% assign latest_post = site.posts.first %}
{% if latest_post %}
<h2 class="linked-section">Latest from the Newsletter</h2>
<article class="post-preview post-preview-card">
  <a href="{{ latest_post.url | relative_url }}" style="text-decoration: none;">
    <h3 class="post-title">{{ latest_post.title }}</h3>
  </a>

  {% if latest_post.subtitle %}
    <h4 class="post-subtitle">
      by {{ latest_post.subtitle }}{% if latest_post.subtitle2 %} and {{ latest_post.subtitle2 }}{% endif %}
    </h4>
  {% endif %}

  <p class="post-meta">Posted on {{ latest_post.date | date: "%B %d, %Y" }}</p>

  <div class="post-entry-container">
    {% assign current_image = latest_post.image_id | default: latest_post.image %}
    {% if current_image %}
      <div class="post-image">
        <a href="{{ latest_post.url | relative_url }}">
          <img src="https://lh3.googleusercontent.com/d/{{ current_image }}?sz=800" alt="{{ latest_post.title }}" loading="lazy">
        </a>
      </div>
    {% endif %}
    <div class="post-entry">
      {{ latest_post.excerpt | strip_html | truncatewords: 30 }}
      <a href="{{ latest_post.url | relative_url }}" class="post-read-more">Read More</a>
    </div>
  </div>
</article>

<p><a href="{{ '/posts/' | relative_url }}">View all Newsletter posts &rarr;</a></p>
{% endif %}
