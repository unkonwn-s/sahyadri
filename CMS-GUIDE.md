# Using Pages CMS to Add Content

This is for anyone adding a Newsletter post, Activity write-up, or Profile who doesn't want to touch GitHub directly. If you're comfortable editing files on GitHub, you don't need this — see `CONTENT-GUIDE.md` instead.

## Before you start

Someone with admin access to the repository needs to have:
1. Installed the Pages CMS GitHub App on this repository (at [app.pagescms.org](https://app.pagescms.org))
2. Added you as a collaborator on the repository, so you have your own access

If you don't have a GitHub account yet, you'll need to create one first (free, at github.com) — this is what identifies you as the author of each change.

## Logging in

1. Go to [app.pagescms.org](https://app.pagescms.org)
2. Sign in with your GitHub account
3. Select the **sahyadri** repository
4. You'll see three sections in the sidebar: **Newsletter Posts**, **Activities**, and **Profiles**

## Adding a Newsletter post or Activity

1. Click **Newsletter Posts** (or **Activities**) in the sidebar
2. Click **Add entry** (usually top right)
3. Fill in the fields:

| Field | What to put |
|---|---|
| Title | The article's headline |
| Date | The actual date this happened/was posted |
| Byline (author) | Full name and role, e.g. "Aadya Tyagi (Class 12)" or "Swati Gautam (Teacher)" |
| Category | The month this belongs under, e.g. "September 2026" (Posts only — must be exactly this format) |
| Thumbnail image | See "Adding images" below |
| Tags | Pick from the list — don't type a new one |
| Article text | The body of the article |

4. Click **Save**

That's it — the site rebuilds automatically within a couple of minutes.

### A few things worth knowing

- **The byline auto-links to a profile.** If you write "Aadya Tyagi (Class 12)" and a profile for Aadya Tyagi already exists, her name becomes a clickable link automatically — you don't need to do anything extra. If the auto-link doesn't work (usually because of a middle name or unusual name format), use the "Profile link override" field to paste the profile's URL directly instead.
- **Two authors?** Use the second byline field, not a comma in the first one.
- **"Pinned"** puts this post above the others in its category on the Newsletter page — use this sparingly, for something you specifically want to stay at the top.

## Adding images

Every image on this site is a **Google Drive file**, not something you upload here. To add one:

1. Upload the photo to Google Drive (if it isn't there already)
2. Right-click the file → **Share** → make sure it's set to **"Anyone with the link can view"**
3. Copy the sharing link — it looks like:
   ```
   https://drive.google.com/file/d/1j2nUEqjoW5XM_AtTaKuq_6v11D8DGyak/view
   ```
4. Copy just the long ID part in the middle (`1j2nUEqjoW5XM_AtTaKuq_6v11D8DGyak` in the example above) — **not** the whole link
5. Paste just that ID into the image field

If a photo doesn't show up on the live site after publishing, the most common reason is the sharing setting — double check it says "Anyone with the link," not "Restricted."

## Adding a Profile

1. Click **Profiles** in the sidebar → **Add entry**
2. **Full name** — write it exactly as it should appear in article bylines (e.g. "Aadya Tyagi"). This is what makes the auto-linking described above work.
3. **Role** — must be exactly one of: `Student (Class 6)` through `Student (Class 12)`, `Teacher`, or `Pre-School`. The form will warn you if this doesn't match.
4. **Academic year** — format `YYYY-YY`, e.g. `2026-27`
5. **Profile photo** — same Google Drive ID process as above; leave it blank if there isn't one yet
6. **Bio** — a short write-up about the person
7. Click **Save**

## What you can't do here

This CMS only covers Newsletter Posts, Activities, and Profiles. **Videos, Photos, and the Krishnamurti/Weekly Excerpts page work differently** and aren't editable through this tool — ask whoever manages the GitHub side to add those, or see `CONTENT-GUIDE.md` if you want to try it yourself.

## If something looks wrong after publishing

Changes usually appear on the live site within a couple of minutes. If a page looks broken or something didn't save right, don't try to fix it by guessing — flag it to whoever manages the site's GitHub repository.
