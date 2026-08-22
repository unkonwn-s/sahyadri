---
# FILE: posts.md
# PURPOSE: Newsletter listing page. Custom tabbed-by-year template (inline <style> block)
# with TOC sidebar. Pulls from _posts collection, grouped by 'category' front matter.
# Jekyll Front Matter Configuration
layout: page
title: "Newsletter"
permalink: /posts/
---

<!-- Page-specific CSS for Tabbed Navigation & Newsletter Layout -->
<style>
  /* CRITICAL: Global image display rules */
  img {
    display: inline-block !important;
    visibility: visible !important;
    opacity: 1 !important;
    max-width: 100%;
    height: auto;
  }

  /* Outer container wrapping the academic year tabs */
  .tabs-container {
    width: 100%;
    margin: 2rem 0 3rem 0;
    border-bottom: 1px solid #e2e8f0;
  }

  /* Flexbox container for tab selection buttons */
  .academic-tabs {
    display: flex;
    justify-content: center;
    gap: 2.5rem;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 1rem;
  }

  /* Individual tab button default styles */
  .tab-link {
    background: none;
    border: none;
    outline: none;
    padding: 0.75rem 0;
    color: #718096;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
    border-bottom: 3px solid transparent;
  }

  /* Hover & Active states for tab buttons */
  .tab-link:hover, .tab-link.active {
    color: #5f745f;
    border-bottom: 3px solid #5f745f;
  }

  /* Content panels hidden by default */
  .academic-panel {
    display: none;
  }

  /* Display active panel with smooth fade-in animation */
  .academic-panel.active {
    display: block;
    animation: fadeIn 0.4s ease;
  }

  /* Author metadata font styling */
  .post-subtitle {
    font-family: 'Amatic SC', cursive, sans-serif !important;
  }

  .post-subtitle a {
    font-family: inherit;
    color: #7a9670;
    text-decoration: none;
  }

  .post-subtitle a:hover {
    text-decoration: underline;
  }

  /* Post card entry layout (thumbnail + content) */
  .post-entry-container {
    display: flex;
    gap: 1.5rem;
    align-items: flex-start;
    margin-top: 1rem;
  }

  .post-image {
    flex-shrink: 0;
    min-width: 200px;
  }

  .post-image img {
    border-radius: 6px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  }

  .post-entry {
    flex: 1;
  }

  .post-read-more {
    display: inline-block;
    margin-left: 0.5rem;
    color: #5f745f;
    font-weight: 600;
    text-decoration: none;
    transition: color 0.2s ease;
  }

  .post-read-more:hover {
    color: #3b4a3b;
    text-decoration: underline;
  }

  /* Fallback message style when an academic year has no posts */
  .no-posts-msg {
    color: #718096;
    font-style: italic;
    padding: 2rem 0;
  }

  /* Keyframe animation for switching tabs */
  @keyframes fadeIn {
    from { opacity: 0; transform: translateY(4px); }
    to { opacity: 1; transform: translateY(0); }
  }

  /* Responsive styling for mobile viewports */
  @media (max-width: 767px) {
    /* Horizontal scrollable tabs on small screens */
    .academic-tabs {
      gap: 1rem;
      justify-content: flex-start;
      overflow-x: auto;
      white-space: nowrap;
      padding-bottom: 0.5rem;
      -webkit-overflow-scrolling: touch;
    }
    
    .tab-link {
      padding: 0.5rem 0.25rem;
      font-size: 0.9rem;
    }
    
    .tabs-container {
      margin: 1rem 0 2rem 0;
    }

    /* Stack thumbnail above text excerpt on mobile */
    .post-entry-container {
      flex-direction: column;
      gap: 1rem;
    }
    
    .post-image {
      flex-shrink: 0;
      width: 85% !important;
      min-width: unset;
      padding: 0;
      margin: 0 auto;
      display: block !important;
      visibility: visible !important;
      opacity: 1 !important;
    }
    
    .post-image a {
      display: block !important;
      visibility: visible !important;
      opacity: 1 !important;
    }
    
    .post-image img {
      width: 100%;
      height: auto;
      max-height: 400px;
      display: block !important;
      visibility: visible !important;
      opacity: 1 !important;
    }

    .post-entry {
      width: 100%;
      padding: 0 1rem;
    }
  }


</style>

{% comment %}
  -----------------------------------------------------------------------------
  STEP 1: Determine Unique Academic Years
  An Academic Year runs from June 1st of year X to March 31st of year X+1.
  This loop iterates through all posts to extract unique start years (e.g., "2023").
  -----------------------------------------------------------------------------
{% endcomment %}

{% assign ay_start_years = "" %}

{% for post in site.posts %}
  {% assign post_month = post.date | date: "%m" | plus: 0 %}
  {% assign post_year  = post.date | date: "%Y" %}

  {% comment %} June (month 6) or later belongs to the current year's academic block {% endcomment %}
  {% if post_month >= 6 %}
    {% assign ay_start = post_year %}
  {% else %}
    {% comment %} Jan-May belongs to the previous calendar year's academic block {% endcomment %}
    {% assign ay_start = post_year | minus: 1 | append: "" | remove: ".0" %}
  {% endif %}

  {% comment %} Deduplicate academic year start values using pipe-delimited string searching {% endcomment %}
  {% assign padded = "|" | append: ay_start_years | append: "|" %}
  {% assign needle  = "|" | append: ay_start | append: "|" %}
  {% unless padded contains needle %}
    {% if ay_start_years == "" %}
      {% assign ay_start_years = ay_start %}
    {% else %}
      {% assign ay_start_years = ay_start_years | append: "|" | append: ay_start %}
    {% endif %}
  {% endunless %}
{% endfor %}

{% comment %} Sort academic years descending so the most recent academic year is first {% endcomment %}
{% assign year_blocks         = ay_start_years | split: "|" | sort | reverse %}
{% assign default_active_year = year_blocks[0] %}

<!-- Scroll anchor for back-to-top links -->
<div id="top" style="scroll-margin-top: 200px;"></div>

<!-- Academic Year Tabs Header -->
<div class="tabs-container">
  <div class="academic-tabs">
    {% for ay in year_blocks %}
      {% comment %} Format e.g., 2023 -> 2023-24 tab label {% endcomment %}
      {% assign ay_end_year  = ay | plus: 1 | append: "" | remove: ".0" %}
      {% assign ay_short_end = ay_end_year | slice: 2, 2 %}
      {% assign tab_id        = "ay-" | append: ay | append: "-" | append: ay_short_end %}
      <button
        class="tab-link {% if ay == default_active_year %}active{% endif %}"
        onclick="switchAcademicYear(event, '{{ tab_id }}')">
        {{ ay }}&#8211;{{ ay_short_end }}
      </button>
    {% endfor %}
  </div>
</div>

{% comment %} Group all Jekyll posts by category {% endcomment %}
{% assign grouped_posts = site.posts | group_by: "category" %}

{% comment %}
  -----------------------------------------------------------------------------
  STEP 2: Render Content Panels per Academic Year
  -----------------------------------------------------------------------------
{% endcomment %}
{% for ay in year_blocks %}
  {% assign ay_end_year         = ay | plus: 1 | append: "" | remove: ".0" %}
  {% assign ay_short_end        = ay_end_year | slice: 2, 2 %}
  {% assign academic_start_date = ay | append: "-06-01" %}
  {% assign academic_end_date   = ay_end_year | append: "-03-31" %}
  {% assign panel_id            = "ay-" | append: ay | append: "-" | append: ay_short_end %}
  {% assign is_active           = false %}
  {% if ay == default_active_year %}
    {% assign is_active = true %}
  {% endif %}

  <div id="{{ panel_id }}" class="academic-panel {% if is_active %}active{% endif %}">
    <div class="newsletter-container">

      <!-- Table of Contents Sidebar (Filters categories active in this AY) -->
      <aside class="toc-sidebar">
        <nav class="toc-card">
          <h2 class="toc-title">Editions</h2>
          <ul class="toc-list">
            {% for group in grouped_posts %}
              {% assign has_posts = false %}
              {% for item in group.items %}
                {% assign item_date = item.date | date: "%Y-%m-%d" %}
                {% if item_date >= academic_start_date and item_date <= academic_end_date %}
                  {% assign has_posts = true %}
                  {% break %}
                {% endif %}
              {% endfor %}
              {% if has_posts %}
                {% assign cat_id = panel_id | append: "-" | append: group.name | slugify %}
                <li><a href="#{{ cat_id }}">{{ group.name | default: "General Updates" }}</a></li>
              {% endif %}
            {% endfor %}
          </ul>
        </nav>
      </aside>

      <!-- Main Content Column for Posts -->
      <div class="posts-list">
        {% assign total_posts = 0 %}

        {% for group in grouped_posts %}
          {% comment %} Pin featured posts to top of their respective category {% endcomment %}
          {% assign pinned_posts = group.items | where: "pinned", true %}
          {% assign normal_posts = group.items | where_exp: "item", "item.pinned != true" %}
          {% assign sorted_posts = pinned_posts | concat: normal_posts %}
          {% assign group_count  = 0 %}

          {% capture group_html %}
            {% for post in sorted_posts %}
              {% assign post_date = post.date | date: "%Y-%m-%d" %}
              {% comment %} Render post only if it falls within current academic year dates {% endcomment %}
              {% if post_date >= academic_start_date and post_date <= academic_end_date %}
                {% assign group_count = group_count | plus: 1 %}
                <article class="post-preview">
                  <!-- Post Title -->
                  <a href="{{ post.url | relative_url }}" style="text-decoration: none;">
                    <h3 class="post-title">{{ post.title }}</h3>
                  </a>

                  <!-- Dynamic Author / Subtitle Attribution (Supports 1 or 2 Authors) -->
                  {% if post.subtitle %}
                    <h4 class="post-subtitle">
                      By
                      {% comment %} Author 1 Profile Link {% endcomment %}
                      {% if post.profile-link %}
                        <a href="{{ post.profile-link }}" target="_blank" rel="noopener noreferrer">{{ post.subtitle }}</a>
                      {% else %}
                        {% assign a1 = post.subtitle | split: " " %}
                        {% capture a1_slug %}{{ a1[0] | downcase }}-{{ a1[1] | downcase }}{% endcapture %}
                        <a href="{{ '/profiles/' | append: a1_slug | append: '/' | relative_url }}">{{ post.subtitle }}</a>
                      {% endif %}

                      {% comment %} Author 2 Profile Link (Optional) {% endcomment %}
                      {% if post.subtitle2 %}
                        and
                        {% if post.profile-link2 %}
                          <a href="{{ post.profile-link2 }}" target="_blank" rel="noopener noreferrer">{{ post.subtitle2 }}</a>
                        {% else %}
                          {% assign a2 = post.subtitle2 | split: " " %}
                          {% capture a2_slug %}{{ a2[0] | downcase }}-{{ a2[1] | downcase }}{% endcapture %}
                          <a href="{{ '/profiles/' | append: a2_slug | append: '/' | relative_url }}">{{ post.subtitle2 }}</a>
                        {% endif %}
                      {% endif %}
                    </h4>
                  {% endif %}

                  <!-- Post Date -->
                  <p class="post-meta">Posted on {{ post.date | date: "%B %d, %Y" }}</p>

                  <!-- Post Excerpt & Google Drive Image Thumbnail -->
                  <div class="post-entry-container">
                    {% assign current_image = post.image_id | default: post.image %}
                    {% if current_image %}
                      <div class="post-image">
                        <a href="{{ post.url | relative_url }}">
                          <img src="https://lh3.googleusercontent.com/d/{{ current_image }}?sz=9999" alt="{{ post.title }}" loading="lazy">
                        </a>
                      </div>
                    {% endif %}
                    <div class="post-entry">
                      {{ post.excerpt | strip_html | truncatewords: 30 }}
                      <a href="{{ post.url | relative_url }}" class="post-read-more">Read More</a>
                    </div>
                  </div>
                </article>
              {% endif %}
            {% endfor %}
          {% endcapture %}

          <!-- Output Category Block if matching posts exist -->
          {% if group_count > 0 %}
            {% assign total_posts = total_posts | plus: group_count %}
            {% assign cat_id = panel_id | append: "-" | append: group.name | slugify %}
            <section class="term-section" id="{{ cat_id }}">
              <h2 class="category-heading">{{ group.name | default: "General Updates" }}</h2>
              {{ group_html }}
              <div class="back-to-top"><a href="#top">&#8593; Back to top</a></div>
            </section>
          {% endif %}
        {% endfor %}

        <!-- Empty State Handling -->
        {% if total_posts == 0 %}
          <p class="no-posts-msg">No newsletters found for this academic period.</p>
        {% endif %}
      </div>

    </div>
  </div>
{% endfor %}

<!-- JavaScript Tab Switcher -->
<script>
  /**
   * Switches visible academic year panel and active tab state.
   * @param {Event} evt - Click event on tab button
   * @param {string} panelId - Target panel element ID
   */
  function switchAcademicYear(evt, panelId) {
    // Hide all panels and remove active state from tab links
    document.querySelectorAll(".academic-panel").forEach(p => p.classList.remove("active"));
    document.querySelectorAll(".tab-link").forEach(t => t.classList.remove("active"));
    
    // Activate target panel and clicked tab
    document.getElementById(panelId).classList.add("active");
    evt.currentTarget.classList.add("active");
  }
</script>
