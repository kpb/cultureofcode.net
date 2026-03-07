# Culture of Code: Hugo version

The Hugo static site generator version of https://cultureofcode.net.

## Building

Display build/deploy targets with `make help`.

## Local linting and formatting

Install local tooling:

```bash
npm install
```

Run checks:

```bash
make lint
```

Apply formatting:

```bash
make format
```

Notes:

- `make lint` checks docs/json and all `*.html` files (including Hugo templates) with Prettier plus TOML files with Taplo.
- `make format` applies the same Prettier/Taplo rules locally.

## Deploy

The site is built and deployed via a [Github workflow](https://github.com/kpb/cultureofcode.net/blob/main/.github/workflows/hugo-build-deploy.yaml).

### Status

![example workflow](https://github.com/kpb/cultureofcode.net/actions/workflows/hugo-build-deploy.yaml/badge.svg)
