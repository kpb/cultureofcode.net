# Repository Guidelines

## Project Structure & Module Organization

This repository is a Hugo static site for `cultureofcode.net`.

- Site config: `hugo.toml`
- Build/deploy automation: `Makefile`, `.github/workflows/hugo-build-deploy.yaml`
- Content: `content/` (blog posts and pages)
- Theme and templates: `themes/coc/` (`layouts/`, `static/css/`, `archetypes/`)
- Static assets copied as-is: `static/` (images, `.htaccess`, favicon)
- Build output (generated): `public/`

Prefer editing source in `content/`, `themes/coc/`, and `static/`; do not hand-edit generated files in `public/`.

## Build, Test, and Development Commands

- `make build`: runs `hugo` and generates the site in `public/`.
- `make try`: runs local dev server with watch mode at `http://localhost:1313`.
- `make clean`: removes `public/`.
- `make deploy`: builds and deploys via `rsync` (requires `DEPLOY_USER` and `DEPLOY_HOST`).
- `make help`: lists available targets.

Typical local loop:

```bash
make clean && make try
```

## Coding Style & Naming Conventions

- Use Hugo templates and front matter conventions already present in the repo.
- Keep indentation and formatting consistent with surrounding files (2 spaces in HTML templates).
- Prefer lowercase, hyphenated filenames for content (for example: `responsive-sticky-footers.md`).
- Keep CSS changes scoped and reuse existing variables/patterns in `themes/coc/static/css/style.css`.

## Testing Guidelines

There is no dedicated automated test suite currently.

- Validate changes by running `make build` (must succeed with no broken templates).
- Manually verify affected pages with `make try`.
- For 404/redirect behavior, confirm generated `public/404.html` and `public/.htaccess` entries.

## Commit & Pull Request Guidelines

Recent history uses Conventional Commits. Follow:

- `fix(scope): ...`
- `style(scope): ...`
- `refactor(scope): ...`
- `chore(scope): ...`

Keep commits focused and atomic. For PRs, include:

- What changed and why
- Any user-visible impact (screenshots for UI/style changes)
- Verification steps performed (`make build`, manual page checks)
- Linked issue (if applicable)

## Security & Configuration Tips

- Never commit secrets; deploy credentials come from GitHub Actions secrets.
- Preserve `static/.htaccess` rules (HTTPS rewrite and custom `404` handling) unless intentionally changing server behavior.
