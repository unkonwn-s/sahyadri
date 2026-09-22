# Sahyadri Connect

A Jekyll site for Sahyadri School, built on the [Beautiful Jekyll](https://beautifuljekyll.com/) theme. Live at **https://connect.sahyadrischool.org**.

This README describes what's actually in the repo. If you're looking at an older version of this file, note that a previous draft described features (Giscus comments, a `layout: events` type, a `pages/` and `_data/` directory) that were never actually built — this version reflects the real site.

## Overview

The site hosts:

- A monthly **Newsletter** (`/posts/`) — student-written articles, grouped by academic year and month
- **Activities** (`/activities/`) — workshops and events, same tabbed-by-year format
- **Profiles** (`/profiles/`) — one page per student/teacher, listed on a searchable directory
- **Krishnamurti / Weekly Excerpts** (`/kfi/`) — embedded videos and linked documents from Krishnamurti Foundation India
- **Videos** (`/videos/`) and **Photos** (`/photos/`) — media galleries, also grouped by year
- **Ninad** (`/ninad/`) and **Geet Gunjan** (`/geeth/`) — PDF archives of school magazines
- A **comments system** on posts, activities, and profile pages, with two interchangeable backends (see below)

## Project structure

```
.
├── _config.yml              # All site settings — see "Configuration" below
├── _posts/                  # Newsletter articles (one file per post)
├── _activities/             # Activity/workshop write-ups
├── _profiles/                # One file per student/teacher profile
├── _layouts/
│   ├── base.html             # <html>/<head>/<body> shell every page extends
│   ├── page.html              # Standard content page (extends base)
│   ├── post.html               # Individual newsletter/activity article page
│   ├── profile.html            # Individual profile page
│   ├── default.html            # Used by 404.html and profiles-directory.html
│   ├── minimal.html             # From the theme; not currently used by any page
├── _includes/
│   ├── head.html, header.html, nav.html, footer.html   # Shared page chrome
│   ├── comments.html          # Router: picks Elfsight or Firebase (below)
│   ├── elfsight-comments.html # Third-party hosted comment widget
│   ├── firebase-comments.html # Custom Firebase comment widget (threads,
│   │                            likes, reactions, moderation queue)
│   ├── toc.html               # Shared table-of-contents sidebar logic
│   └── pdf.html                # Renders one PDF thumbnail card (Ninad/Geet Gunjan)
├── assets/
│   ├── css/custom-styles.css  # All site-specific CSS (the theme's own CSS
│   │                            files are untouched)
│   ├── img/                    # Local images (Newsletter/Photos galleries,
│   │                            favicons, avatar)
│   ├── Ninads/, GeethGunjan/    # PDF archives + their thumbnail images
│   └── js/                     # Theme JS (from Beautiful Jekyll, not custom)
├── index.md                  # Homepage (a short welcome blurb, no post feed)
├── posts.md                  # Newsletter listing page
├── activities.md             # Activities listing page
├── profiles.html             # Profiles directory (dynamic year/category UI)
├── profiles-directory.html   # Fallback page for authors without a profile
│                                yet (permalink: /not_done_yet)
├── videos.html, photos.html, kfi.html   # Media gallery pages
├── ninad.md, geeth-gunjan.md   # PDF archive pages
├── tags.html                  # Tag index (currently unused — no post or
│                                activity sets a `tags:` field yet)
├── comms.md                   # Static "how to reach us" page
├── maintenance.html            # Maintenance-mode landing page (see below)
├── approve.html                # Comment moderation review page (see below)
└── 404.html                    # Custom not-found page
```

## Content authoring

### Newsletter post

Add a file to `_posts/` named `YYYY-MM-DD-slug.md`:

```yaml
---
layout: post
title: "ASSEMBLY BY VEERARAGHAV SIR"
date: 2026-09-04
subtitle: "Bhagyashree Patil (Teacher)"      # Byline — auto-linked to a profile
subtitle2: ""                                # Optional co-author, same rules
profile-link: ""                             # Optional: override the auto-generated profile link
profile-link2: ""
category: "September 2026"                   # Groups posts into the newsletter's month sections
image: ""                                    # Google Drive file ID for the thumbnail (see below)
image2: "" 
image3: ""
image4: ""
image5: ""
pinned: false                                # true pins this post above its category's other posts
---

Article text in Markdown.
```

**How the byline link works:** `subtitle`/`subtitle2` is split into first and last word, lowercased and hyphenated (`"Bhagyashree Patil"` → `bhagyashree-patil`), and checked against `_profiles/` filenames. If a match exists, the name links to that profile page. If not, it links to `/not_done_yet` (served by `profiles-directory.html`) instead of a broken link. Names with a middle name/initial or an unusual format won't match automatically — use `profile-link`/`profile-link2` to point at the right page directly in that case.

### Activity

Same format as a post, in `_activities/` instead:

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

Note: activities use `layout: post` — the same layout as newsletter articles — not a separate `events` layout.

### Profile

Add a file to `_profiles/` named `first-last.md` (must match the slug the byline logic above generates):

```yaml
---
layout: profile
title: "Aadya Tyagi"
subtitle: "Student (Class 12)"    # Also drives the weighting/grouping on the profiles directory page
date: 2026-06-29
academic-year: "2026-27"
profile-image: ""                  # Google Drive file ID
---

Bio text in Markdown.
```

`subtitle` should read `"Student (Class N)"` or a role like `"Teacher"` — `profiles.html`'s sorting logic looks for these substrings to group and order the directory.

### Images (Google Drive)

Image fields (`image`, `profile-image`, etc.) take a **Google Drive file ID**, not a URL — extract it from the sharing link:

```
https://drive.google.com/file/d/  1j2nUEqjoW5XM_AtTaKuq_6v11D8DGyak  /view
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                    this part goes in the front matter field
```

The file must be shared as "Anyone with the link can view." Pages render these via `https://lh3.googleusercontent.com/d/<id>` rather than linking to the Drive page directly.

Local images (used in the Photos/Newsletter static galleries) live under `assets/img/`.

### Ninad / Geet Gunjan PDFs

These use `_includes/pdf.html`, which expects a card wrapper with a `thumbnail_path` (a local image under `assets/`) and a `pdf_path` (an external Drive link). See `ninad.md` or `geeth-gunjan.md` for the exact pattern.

## Comments system

`_includes/comments.html` is a router: it checks `page.comments` (set via the collection defaults in `_config.yml` for posts/activities/profiles) and `site.comments-provider`, then includes one of:

- **`elfsight-comments.html`** (default) — a hosted third-party widget. Configured via `elfsight-app-id`.
- **`firebase-comments.html`** — a custom-built widget: Google sign-in, threaded replies, likes, emoji reactions, sort by newest/oldest/most-liked, edit/delete your own comment, and a moderation queue.

### Firebase comments moderation

New comments save with `approved: false` and are visible only to their author until approved. The widget uses two separate Firestore queries (a public one requiring `approved == true`, and a second scoped to the signed-in viewer's own `uid`) rather than one broad read filtered client-side, so a Firestore security rule can actually validate what each query is allowed to see.

To review and approve a pending comment: **`approve.html`** (at the repo root, `noindex`) takes a `?id=<commentId>` query param, requires signing in as the address in `comments-moderator-email`, and shows an Approve/Reject UI. If `emailjs-*` config values and `comments-moderator-email` are all set, a new comment also triggers an email (via EmailJS) with a direct link to that page.

**Important:** none of the interactive Firebase features (posting, liking, editing, deleting, approving) work until the Firestore security rules for the `comments` collection are published in the Firebase console — that's a manual step outside this repo. Don't leave Firestore in open "test mode" on a real deployment, since visitors sign in with their real Google accounts here.

## Maintenance mode

Setting `maintenance-mode: true` in `_config.yml` redirects every page to `/maintenance/`. To preview the site while it's on, visit:

```
https://connect.sahyadrischool.org/?bypass=<maintenance-bypass-key>
```

This unlocks browsing for the rest of that browser tab's session (via `sessionStorage`) — it resets when the tab closes. Change `maintenance-bypass-key` any time to invalidate old bypass links. Note this repo is public, so the key isn't a real secret; it just keeps casual visitors from stumbling onto the bypass.

`maintenance.html` itself also reverse-redirects to the homepage if someone lands on it while maintenance mode is actually off (e.g. from a stale cached page) — see its own comments for details.

`approve.html` intentionally bypasses the maintenance-mode redirect entirely, so a moderator can still approve/reject comments while the rest of the site is down.

## Configuration reference (`_config.yml`)

| Key | Purpose |
|---|---|
| `url`, `baseurl`, `title`, `author`, `description` | Basic site identity |
| `maintenance-mode`, `maintenance-bypass-key` | See above |
| `navbar-links` | Nav bar structure — top-level and dropdown items |
| `post_search` | Enables the year-scoped search box on the Newsletter/Activities pages |
| `page-col`, `text-col`, `link-col`, `hover-col`, `navbar-*`, `footer-*` | Color palette, consumed as CSS custom properties |
| `date_format` | Display format for post/activity dates |
| `comments-provider` | `"elfsight"` or `"firebase"` |
| `elfsight-app-id` | Elfsight widget config |
| `firebase-*` (six keys) | Firebase project config for the custom comments widget |
| `emailjs-*`, `comments-moderator-email` | Optional moderation email notifications |
| `defaults` | Per-collection layout/front-matter defaults (posts/activities get `layout: post`; profiles get `layout: profile`; everything else gets `layout: page`) |
| `collections` | Registers `posts`, `activities`, `profiles` as output collections with their permalink patterns |

## Local development

```bash
bundle install
bundle exec jekyll serve
```

Then visit `http://localhost:4000`. Note: `jekyll-paginate` is **not** installed (see the Gemfile's own comment on version conflicts) -- relevant if a paginated post-feed page is ever built, since that plugin isn't available here.

## Deployment

Deployment runs via a GitHub Actions workflow (`.github/workflows/ci.yml`) on every push to `master` — it builds the Jekyll site and publishes it to GitHub Pages. There's no separate manual deploy step; pushing to `master` is the deploy.

## Design notes

- Fonts: **Amatic SC** (display headings), **Poiret One** (theme body/nav text), and **Montserrat** (post/article body text) — all loaded via Google Fonts in `_includes/head.html`.
- Dark mode is a `.dark-mode` class toggled on `<body>`; most components have a corresponding `.dark-mode .component { ... }` override in `custom-styles.css` rather than CSS variables for dark-mode-specific colors.
- All page-specific CSS lives in `assets/css/custom-styles.css`, organized into numbered sections (see the file's own comments) — the theme's own CSS files (`beautifuljekyll.css`, etc.) are left untouched.

## Known gaps

- **`tags.html`** is fully functional but currently shows nothing — no post or activity sets a `tags:` front matter field yet.
- **`geeth-gunjan.md`** has two PDF cards ("Original" and "English Transliterated") sharing the same thumbnail image; a comment in the file flags this as needing the correct second thumbnail's Google Drive file ID.
- A handful of `_includes` files (`analytics.html`, `google_analytics.html`, `gtag.html`, `gtm_head.html`, `gtm_body.html`, `matomo.html`, `mathjax.html`) are theme-provided hooks not currently wired to real tracking IDs.
