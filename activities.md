---
# FILE: activities.md
# PURPOSE: Activities listing page. Custom tabbed-by-year template (inline <style> block)
# similar to posts.md/kfi.html. Pulls from _activities collection.
layout: page
title: "Activities"
---

<!--
  activities.html — Activities listing page
  ==========================================
  Displays site.activities collection posts grouped by category, filtered by
  academic year. Each year is shown in its own tab panel; switching tabs
  animates in the relevant panel and scrolls back to the top anchor.

  Data flow:
    1. year_blocks   — pipe-separated list of academic years to show as tabs
                       (e.g. "2024-25|2025-26") plus the special token "archive"
    2. valid_activities — activities with a date set, grouped by category
    3. For each year, the academic period is June 1 – March 31 of the next year
    4. Within each category, pinned posts are hoisted to the top, then remaining
       posts are sorted newest-first

  Front matter used on each activity:
    date      (required) — used for year filtering and sort order
    title     (required) — post heading
    subtitle  (optional) — primary author full name; auto-linked to /profiles/<slug>/
    subtitle2 (optional) — secondary author, rendered as "and <name>"
    category  (optional) — groups posts under a section heading; defaults to "General Updates"
    image     (optional) — thumbnail shown in the post preview card
    pinned    (optional) — set to true to pin the post to the top of its category
-->

<style>
  /* CRITICAL: Global image display rules — page-specific since making this
     truly site-wide (in custom-styles.css) could affect other pages' image
     requirements. Everything else previously here has been consolidated
     into custom-styles.css section 26, shared with posts.md. */
  img {
    display: inline-block !important;
    visibility: visible !important;
    opacity: 1 !important;
    max-width: 100%;
    height: auto;
  }
</style>

<!--
  year_blocks: pipe-separated list of academic year tokens rendered as tabs.
  Add years here to show additional tabs, e.g. "2024-25|2025-26|archive".
  The special token "archive" creates a catch-all tab for older content.
-->
{% assign year_blocks = "2025-26" | split: "|" %}

<!-- The tab that is open when the page first loads -->
{% assign default_active_year = "2025-26" %}

<!-- Scroll target: tab switches smooth-scroll back here via switchAcademicYear() -->
<div id="top" style="scroll-margin-top: 200px;"></div>

<!-- ── Tab buttons ── -->
<div class="tabs-container">
  <div class="academic-tabs">
    {% for current_year in year_blocks %}
      {% if current_year == "archive" %}
        {% assign tab_id    = "ay-archive" %}
        {% assign tab_label = "Archive" %}
      {% else %}
        <!--
          Derive a short label from the year token (e.g. "2025-26" → "2025–26").
          tab_id format: ay-<start>-<short_end>  e.g. "ay-2025-26"
        -->
        {% assign start_yr     = current_year | plus: 0 %}
        {% assign short_end_yr = start_yr | plus: 1 | slice: 2, 2 %}
        {% assign tab_id       = "ay-" | append: start_yr | append: "-" | append: short_end_yr %}
        {% assign tab_label    = start_yr | append: "–" | append: short_end_yr %}
      {% endif %}

      <button
        class="tab-link {% if current_year == default_active_year %}active{% endif %}"
        onclick="switchAcademicYear(event, '{{ tab_id }}')">
        {{ tab_label }}
      </button>
    {% endfor %}
  </div>
</div>

<!--
  Pre-process activities once, outside the year loop:
  - Exclude any activity without a date (prevents sort/filter errors)
  - Group by category and sort groups alphabetically
-->
{% assign valid_activities = site.activities | where_exp: "item", "item.date != nil" %}
{% assign grouped_posts    = valid_activities | group_by: "category" | sort: "name" %}

<!-- ── Year panels ── -->
{% for current_year in year_blocks %}

  <!--
    Determine the date range and panel ID for this year.
    Academic year runs June 1 of start_yr to March 31 of end_yr.
    "archive" catches everything before the earliest regular tab.
  -->
  {% if current_year == "archive" %}
    {% assign academic_start_date = "1970-01-01" %}
    {% assign academic_end_date   = "2024-05-31" %}
    {% assign panel_id            = "ay-archive" %}
  {% else %}
    {% assign start_yr     = current_year | plus: 0 %}
    {% assign end_yr       = start_yr | plus: 1 %}
    {% assign short_end_yr = end_yr | slice: 2, 2 %}

    {% assign academic_start_date = start_yr | append: "-06-01" %}
    {% assign academic_end_date   = end_yr   | append: "-03-31" %}
    {% assign panel_id            = "ay-" | append: start_yr | append: "-" | append: short_end_yr %}
  {% endif %}

  {% assign is_active = false %}
  {% if current_year == default_active_year %}
    {% assign is_active = true %}
  {% endif %}

  <div id="{{ panel_id }}" class="academic-panel {% if is_active %}active{% endif %}">
    <div class="newsletter-container">

      <!-- ── Sidebar TOC ── -->
      <!--
        Lists only the categories that have at least one post in this year's
        date range. Each entry links to the corresponding section below.
        Anchor format: <panel_id>-<slugified-category>
      -->
      <aside class="toc-sidebar">
        <nav class="toc-card">
          <h2 class="toc-title">Activities</h2>
          <ul class="toc-list">
            {% for group in grouped_posts %}
              {% assign has_current_posts = false %}

              {% for item in group.items %}
                {% assign item_date = item.date | date: "%Y-%m-%d" %}
                {% if item_date >= academic_start_date and item_date <= academic_end_date %}
                  {% assign has_current_posts = true %}
                  {% break %}
                {% endif %}
              {% endfor %}

              {% if has_current_posts %}
                {% assign category_id = panel_id | append: "-" | append: group.name | slugify | default: "general-updates" %}
                <li>
                  <a href="#{{ category_id }}">{{ group.name | default: "General Updates" }}</a>
                </li>
              {% endif %}
            {% endfor %}
          </ul>
        </nav>
      </aside>

      <!-- ── Posts list ── -->
      <div class="posts-list">
        {% assign total_displayed_posts = 0 %}

        {% for group in grouped_posts %}
          <!--
            Sort order within each category:
              1. Pinned posts (pinned: true) — always shown first
              2. Remaining posts — newest date first
          -->
          {% assign date_sorted_posts = group.items | sort: "date" | reverse %}
          {% assign pinned_posts      = date_sorted_posts | where: "pinned", true %}
          {% assign normal_posts      = date_sorted_posts | where_exp: "item", "item.pinned != true" %}
          {% assign sorted_posts      = pinned_posts | concat: normal_posts %}

          {% assign current_group_count = 0 %}

          <!--
            Capture the rendered HTML for this category's posts so we can
            check current_group_count before deciding whether to output the
            category heading and section wrapper. This avoids rendering empty
            sections for categories with no posts in the current year.
          -->
          {% capture group_output %}
            {% for post in sorted_posts %}
              {% assign post_date = post.date | date: "%Y-%m-%d" %}
              {% if post_date >= academic_start_date and post_date <= academic_end_date %}
                {% assign current_group_count = current_group_count | plus: 1 %}

                <article class="post-preview">

                  <!-- Post title — links to the full activity page -->
                  <a href="{{ post.url | relative_url }}" style="text-decoration: none;">
                    <h3 class="post-title">{{ post.title }}</h3>
                  </a>

                  <!--
                    Author byline (subtitle / subtitle2).
                    Each author name is converted to a profile URL slug:
                      "First Last" → /profiles/first-last/
                    subtitle2, if present, is appended as "and <name>".
                  -->
                  {% if post.subtitle %}
                    {% assign author1_parts = post.subtitle | split: ' ' %}
                    {% capture author1_slug %}{{ author1_parts[0] | downcase }}-{{ author1_parts[1] | downcase }}{% endcapture %}
                    {% assign profile1_url = '/profiles/' | append: author1_slug | append: '/' | relative_url %}

                    <h4 class="post-subtitle">
                      By <a href="{{ profile1_url }}">{{ post.subtitle }}</a>{% if post.subtitle2 %}{% assign author2_parts = post.subtitle2 | split: ' ' %}{% capture author2_slug %}{{ author2_parts[0] | downcase }}-{{ author2_parts[1] | downcase }}{% endcapture %}{% assign profile2_url = '/profiles/' | append: author2_slug | append: '/' | relative_url %} and <a href="{{ profile2_url }}">{{ post.subtitle2 }}</a>{% endif %}
                    </h4>
                  {% endif %}

                  <!-- Publication date, formatted via site.date_format with a fallback -->
                  <p class="post-meta">
                    Posted on {{ post.date | date: site.date_format | default: "%B %d, %Y" }}
                  </p>

                  <!-- Thumbnail + excerpt row -->
                  <div class="post-entry-container">
                    {% if post.image %}
                      <div class="post-image">
                        <a href="{{ post.url | relative_url }}">
                          <img src="https://lh3.googleusercontent.com/d/{{ post.image }}?sz=9999" alt="{{ post.title }}">
                        </a>
                      </div>
                    {% endif %}

                    <div class="post-entry">
                      <!-- Excerpt: first 30 words of body text, HTML stripped -->
                      {{ post.excerpt | strip_html | truncatewords: 30 }}
                      <a href="{{ post.url | relative_url }}" class="post-read-more">Read More</a>
                    </div>
                  </div>

                </article>
              {% endif %}
            {% endfor %}
          {% endcapture %}

          <!-- Only render the section if at least one post matched this year -->
          {% if current_group_count > 0 %}
            {% assign total_displayed_posts = total_displayed_posts | plus: current_group_count %}
            {% assign category_id = panel_id | append: "-" | append: group.name | slugify | default: "general-updates" %}

            <section class="term-section" id="{{ category_id }}">
              <h2 class="category-heading">
                {{ group.name | default: "General Updates" }}
              </h2>

              {{ group_output }}

              <div class="back-to-top">
                <a href="#top">↑ Back to top</a>
              </div>
            </section>
          {% endif %}

        {% endfor %}

        <!-- Fallback message when the selected year has no activities at all -->
        {% if total_displayed_posts == 0 %}
          <p class="no-posts-msg">No activities found for this academic period.</p>
        {% endif %}

      </div><!-- /.posts-list -->
    </div><!-- /.newsletter-container -->
  </div><!-- /.academic-panel -->

{% endfor %}

<script>
  /**
   * switchAcademicYear — tab switching handler
   *
   * Called by the onclick of each tab button. Hides all year panels and
   * deactivates all tab buttons, then activates the selected panel and tab,
   * and smooth-scrolls back to the #top anchor so the user lands at the
   * top of the newly revealed content.
   *
   * @param {MouseEvent} evt     - the click event from the tab button
   * @param {string}     panelId - the id of the panel to show (e.g. "ay-2025-26")
   */
  function switchAcademicYear(evt, panelId) {
    // Deactivate all panels
    const panels = document.getElementsByClassName("academic-panel");
    for (let i = 0; i < panels.length; i++) {
      panels[i].classList.remove("active");
    }

    // Deactivate all tab buttons
    const tabs = document.getElementsByClassName("tab-link");
    for (let i = 0; i < tabs.length; i++) {
      tabs[i].classList.remove("active");
    }

    // Activate the selected panel and its corresponding tab button
    document.getElementById(panelId).classList.add("active");
    evt.currentTarget.classList.add("active");

    // Scroll back to the top anchor smoothly
    document.getElementById("top").scrollIntoView({ behavior: 'smooth' });
  }
</script>
