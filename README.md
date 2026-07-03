# Behavioural Ecology and Data Science Lab — website

A clean, static rebuild of the old Weebly site (`tylerbonnell.weebly.com`), ready to host for free on GitHub Pages. It's plain HTML and CSS — no build step, no framework — so updating it later means editing a text file and saving.

## What's in this folder

```
lab-website/
├── index.html            Home
├── people.html           People (members, alumni, recruitment)
├── research.html         Research projects
├── teaching.html         Courses
├── publications.html     Full publication list with PDF links
├── css/style.css         All styling (one file)
├── download_assets.sh    One-time script to pull images + PDFs from Weebly
├── .nojekyll             Tells GitHub Pages to serve the files as-is
└── assets/
    ├── img/              Images (populated by the script)
    └── pdf/              Publication PDFs (populated by the script)
```

## Step 0 — Get the images and PDFs (do this first)

The old site's images and ~45 publication PDFs still live on Weebly. Run the
included script once to download them all into `assets/`:

```bash
cd lab-website
bash download_assets.sh
```

It reports `ok` / `FAIL` per file. If anything fails, re-run it, or grab those
few files manually from the old Weebly site and drop them into `assets/img` or
`assets/pdf` (keep the same filenames). Once this is done, the site is fully
self-contained and Weebly can be cancelled.

> Preview locally anytime: run `python3 -m http.server` in this folder, then
> open `http://localhost:8000`.

## Step 1 — Create the GitHub repository

You have two naming choices:

- **User site (recommended):** name the repo exactly `USERNAME.github.io`
  (e.g. `tbonnell.github.io`). It publishes at `https://USERNAME.github.io`.
- **Project site:** any name (e.g. `lab-website`). It publishes at
  `https://USERNAME.github.io/lab-website/`.

On github.com: **New repository** → set the name → **Public** → Create.

## Step 2 — Upload the files

**Option A — drag and drop (no command line):**
On the empty repo page, click **uploading an existing file**, then drag in
*everything inside* the `lab-website` folder (the `.html` files, `css/`,
`assets/`, `.nojekyll`). Commit.

**Option B — git command line:**
```bash
cd lab-website
git init
git add .
git commit -m "Initial site"
git branch -M main
git remote add origin https://github.com/USERNAME/REPO.git
git push -u origin main
```

## Step 3 — Turn on GitHub Pages

Repo → **Settings** → **Pages** → under *Build and deployment*, set
**Source: Deploy from a branch**, **Branch: `main`**, folder **`/ (root)`** →
Save. Wait ~1 minute, then reload — the URL appears at the top of that page.

## Step 4 — (Optional) Use a custom domain

If you have a domain (e.g. `bonnell-lab.ca`): in **Settings → Pages → Custom
domain**, enter it and save (this creates a `CNAME` file in the repo). Then at
your domain registrar add DNS records pointing to GitHub — an `ALIAS`/`CNAME`
to `USERNAME.github.io`, or four `A` records to GitHub's IPs. Tick **Enforce
HTTPS** once it validates. A university subdomain (e.g. a page under
`ucalgary.ca`) works the same way if IT sets up the CNAME.

## Maintaining the site

Everyday edits are just text changes:

- **Add a publication:** open `publications.html`, copy an existing `<li>…</li>`
  block, edit the authors/title/venue/year, and point the link at your new PDF
  in `assets/pdf/`.
- **Add a lab member:** open `people.html`, copy a `<div class="person">` card,
  change the initials, name, role, and blurb. To use a real photo instead of
  the initials circle, replace `<div class="avatar">XY</div>` with
  `<img class="avatar" src="assets/img/their-photo.jpg" alt="Name">`.
- **Edit text:** the words on each page sit in plain HTML — just type over them.

Then publish the change:
- *Web:* open the file on github.com, click the pencil ✏️, edit, **Commit**.
- *Command line:* `git add . && git commit -m "Update" && git push`.

The live site refreshes within a minute or two of each commit. Because it's Git,
every change is versioned and reversible.

### A couple of things to check
- **Home banner:** the Home page shows a full-width landscape banner pulled from
  `assets/img/hero.jpg`. Drop a wide landscape photo there (that exact filename)
  and it appears automatically. Until you add one, a soft green panel shows in
  its place — nothing breaks.
- **Email:** `index.html` uses `tyler.bonnell@ucalgary.ca` (matches your
  UCalgary profile). Update it if you'd prefer a different address.
- **Photos:** member cards currently show initials. Add real headshots to
  `assets/img/` and swap them in as shown above whenever you like.

---

## Is GitHub Pages the best choice for an academic lab site?

Short answer: **yes, for your case it's a solid default** — but Cloudflare Pages
is an equally free alternative worth knowing about, and it's the one to switch
to only if you ever hit GitHub's traffic ceiling. Here's the reasoning.

Your site is *static* (plain pages, images, and PDFs — no database, logins, or
server code). Every option below serves static sites for free; they differ
mainly in limits and workflow.

| Platform | Cost | Bandwidth (free) | Custom domain + HTTPS | Notes for a lab site |
|---|---|---|---|---|
| **GitHub Pages** | Free (public repo) | ~100 GB/mo (soft) | Yes, free | Simplest path, huge academic community, version-controlled. Static only. |
| **Cloudflare Pages** | Free | **Unlimited** | Yes, free | Best if you expect heavy traffic; slightly more setup. |
| **Netlify** | Free | 100 GB/mo | Yes, free | Adds forms + deploy previews; commercial use allowed. |
| **GitLab Pages** | Free | Generous | Yes, free | Good if your institution already uses GitLab. |
| **University hosting** | Free | Varies | Institutional domain | Most "official," but often slow to update and requires IT tickets. |

Why GitHub Pages fits an academic lab specifically:

- **It's free and stays free** for public repositories, with no ads (unlike the
  Weebly free tier's footer).
- **Updating is trivial and safe.** Editing a lab site is mostly adding
  publications and students — a one-line text edit and a commit. Git keeps a
  full history, so nothing is ever lost and mistakes are one click to undo. That
  directly addresses your goal of a simpler update workflow.
- **It's the academic standard.** Popular lab/CV templates
  (`academicpages`, `al-folio`, Hugo academic themes) are built for GitHub
  Pages, so if you ever want a fancier design there's a large, well-documented
  ecosystem and lots of peers to ask.
- **Custom domains are free**, so you can point a `.ca` or university subdomain
  at it later without changing anything else.

The honest limitations: GitHub Pages serves **static content only** (no contact
forms, no server-side code), the bandwidth limit is a *soft* 100 GB/month, and
free hosting must be from a **public** repo. None of these matter for a lab
website — 100 GB/month is enormous for this kind of traffic, a public repo of
HTML is a non-issue, and a contact email replaces a contact form fine. If you
ever needed a working contact form or outgrew the bandwidth, **Cloudflare
Pages** (unlimited bandwidth) or **Netlify** (built-in forms) are drop-in free
alternatives that host the *exact same files* — so you're not locked in either
way.

Recommendation: **start with GitHub Pages.** It's the best balance of free,
simple, durable, and standard for an academic lab, and migrating elsewhere later
is painless because the site is just static files.
