# Content Guide: Adding to Sahyadri Connect

Step-by-step instructions for adding each type of content. For the technical/developer overview of the site, see `README.md`.

**General rule for every Google Drive image or PDF referenced below:** the file must be shared as "Anyone with the link can view," and the ID you need is the long string in the sharing URL:

```
https://drive.google.com/file/d/  1j2nUEqjoW5XM_AtTaKuq_6v11D8DGyak  /view
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                    this is the file ID
```

---

## Newsletter post

**File:** add a new file to `_posts/`, named `YYYY-MM-DD-a-short-slug.md` (the date must match the date the post is set to; Jekyll uses the filename to derive it).

```yaml
---
layout: post
title: "ASSEMBLY BY VEERARAGHAV SIR"
date: 2026-09-04
subtitle: "Bhagyashree Patil (Teacher)"
category: "September 2026"
image: ""
---

Article text in Markdown goes here.
```

- **`subtitle`** is the byline. It's split into first/last word and checked against `_profiles/` filenames to auto-link to that person's profile page — if there's no match, it links to a generic "profile not set up yet" page instead of breaking. A middle name, initial, or hyphenated surname will usually not match automatically; add `profile-link: "https://..."` to point it at the right page directly.
- **`category`** groups the post under a month heading on the Newsletter page (`/posts/`) — use `"Month YYYY"`, matching the existing convention.
- **`image`** (optional) is a Google Drive file ID for the post's thumbnail. There's also `image2`–`image5` for a small gallery, and `pinned: true` to pin the post above others in its category.
- Two authors: add `subtitle2` (and `profile-link2` if needed) the same way.
- **`tags`** (optional) is a list, e.g. `tags: [sports, workshop]`. It shows as a "Tags:" line on the article and appears grouped on the Tag index page (`/tags/`) — only for Newsletter posts, though; this is a Jekyll limitation (`site.tags` only reads `_posts`), so adding `tags` to an Activity write-up won't show up there. There's no fixed list of allowed tags — reuse an existing one where it fits (check `/tags/` for what's already in use) rather than inventing near-duplicates.

Nothing else needs updating — the Newsletter page automatically groups posts by academic year and category from what's already in `_posts/`.

---

## Activity

**File:** add a new file to `_activities/`, same filename convention as posts.

```yaml
---
layout: post
title: "Digital Safety Workshop"
date: 2025-09-22
subtitle: "Sayantan Sen (Founder, Digital Safety India)"
category: "Digital Safety Workshop"
image: ""
---
```

Same rules as a Newsletter post (byline auto-linking, `image`, `pinned`) — activities and posts share the same layout and page logic, just live in a separate collection and separate listing page (`/activities/`).

---

## Profile

**File:** add a new file to `_profiles/`, named `first-last.md` — lowercase, hyphenated, matching what a post's byline auto-link would generate (e.g. "Aadya Tyagi" → `aadya-tyagi.md`).

```yaml
---
layout: profile
title: "Aadya Tyagi"
subtitle: "Student (Class 12)"
date: 2026-06-29
academic-year: "2026-27"
profile-image: ""
---

Bio text in Markdown.
```

- **`subtitle`** must read `"Student (Class N)"` (any class 6–12) or a role like `"Teacher"` or `"Pre-School"` — the Profiles directory page (`/profiles/`) uses this text to sort and group entries. Anything else will still show, just without a sensible sort position.
- **`profile-image`** is optional; without one, a default placeholder photo is used.
- The profile page automatically builds an "Articles by {name}" list at the bottom, pulling in every post/activity whose byline matches this person — nothing to add here for that to work, as long as the filename matches the byline the way posts already expect (see the Newsletter post section above).

---

## Photos album

**Easiest way:** use Pages CMS (see `CMS-GUIDE.md`) — the Photos collection there gives a proper "Add entry" form.

**By hand:** add an entry to `_data/photos.yml`:

```yaml
- drive_id: "FILE_ID_HERE"
  album_link: "GOOGLE_PHOTOS_LINK"
  title: "Event Name"
  date: 2026-08-31
  date_display: "31st August 2026"
```

- `drive_id` is the Google Drive file ID of the thumbnail (share settings as above).
- `album_link` is the actual Google Photos album link (shared separately, viewable by anyone with the link) — this is what visitors land on when they click.
- `date` is only used to sort albums newest-first — it's never shown on the site.
- `date_display` is the exact text shown under the title. For a multi-day event, write it as a range: `"31st August – 1st September 2026"`.
- Order in the file doesn't matter — `photos.html` sorts by `date` automatically at build time.

---

## Video

**Easiest way:** use Pages CMS (see `CMS-GUIDE.md`) — the Videos collection there gives a proper "Add entry" form.

**By hand:** add an entry to `_data/videos.yml`:

```yaml
- youtube_id: "YOUTUBE_VIDEO_ID"
  title: "Event Name"
  date: 2026-09-04
```

- `youtube_id` is the 11-character ID from the video's URL (`youtube.com/watch?v=`**`THIS_PART`**).
- `videos.html` generates the "DDth Month YYYY" caption automatically from `date` — no need to write it out yourself.
- Order in the file doesn't matter — sorted newest-first automatically at build time.

---

## Krishnamurti / Weekly Excerpts (`kfi.html`)

This page is more involved than the others: entries are grouped by year using a *manually maintained* list (unlike Videos/Photos, which compute years automatically), and there are two different entry types.

### Adding a new academic year tab

Near the top of the file:

```liquid
{% assign year_blocks = "2025" | split: "|" %}
{% assign default_active_year = "2025" %}
```

To add 2026 as a new tab, change the first line to `"2025|2026"` and update `default_active_year` to `"2026"` if the new year should be the one shown by default.

### Adding an embedded YouTube video

```html
<figure class="video-item" data-year="2025">
    <div class="video-wrapper" onclick="loadVideo(this)" data-video="YOUTUBE_VIDEO_ID">
        <img src="https://img.youtube.com/vi/YOUTUBE_VIDEO_ID/hqdefault.jpg" class="thumbnail" alt="Excerpt Title">
    </div>
    <figcaption class="video-caption">
        Excerpt - <a href="https://www.youtube.com/watch?v=YOUTUBE_VIDEO_ID" target="_blank">Excerpt Title</a>,
        Published on - Mon DD, YYYY
    </figcaption>
</figure>
```

### Adding a document link (no video, just a linked PDF/Drive file)

```html
<figure class="video-item" data-year="2025">
    <figcaption class="video-caption">
        Excerpt - <a href="https://drive.google.com/file/d/FILE_ID/view?usp=sharing" target="_blank">Excerpt Title</a>,
        Published on - Mon DD, YYYY
    </figcaption>
</figure>
```

- `data-year` must match one of the values in `year_blocks` above — this is how entries get grouped, unlike Videos/Photos' automatic date parsing.
- Add new entries at the top of their year's block for newest-first order.

---

## Ninad / Geet Gunjan (PDF archives)

**Files:** `ninad.md` or `geeth-gunjan.md`.

```liquid
<figure class="ninad-card">
  {% include pdf.html 
     thumbnail_path="/assets/Ninads/YEAR.png" 
     pdf_path="https://drive.google.com/uc?export=download&id=FILE_ID" 
     only_thumbnail=true %} 
  <figcaption class="ninad-caption-banner">Ninad YYYY-YY</figcaption>
</figure>
```

- `thumbnail_path` is a **local** image (upload a cover-page screenshot to `assets/Ninads/` or `assets/GeethGunjan/` first, then reference it here — this is the one field in this whole guide that isn't a Google Drive ID).
- `pdf_path` is a direct-download Drive link built from the file ID: `https://drive.google.com/uc?export=download&id=FILE_ID`.
- `geeth-gunjan.md` currently has two cards sharing the same thumbnail image by mistake (see `README.md`'s "Known gaps" section) — if you're fixing that, this is the pattern to follow for the corrected thumbnail.

---

## After adding content

Nothing needs to be built or triggered manually — pushing to `master` automatically builds and deploys the site (see `README.md`'s "Deployment" section). Check the **Actions** tab on GitHub after pushing to confirm the build succeeded before assuming the change is live.
