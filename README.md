# animovement.dev

The [Quarto](https://quarto.org) website behind [animovement.dev](https://animovement.dev):
the marketing front page **and** the central home for cross-package learning
tutorials. Each individual package keeps its own pkgdown reference site at
`animovement.dev/<package>`; this hub is for the pitch, get-started, and
**end-to-end, cross-package** workflows.

## Structure

| Path | Page |
| --- | --- |
| `index.qmd` | Landing page (custom hero + package grid) |
| `packages/` | The package ecosystem, linking to each pkgdown site |
| `start/` | Get Started — install / load / learn |
| `help/` | Getting help — issues, discussions, contributing |
| `learn/` | Tutorial listing + cross-package tutorials |
| `_brand.yml` | Central brand: accent colour (teal) + fonts (Lato / Source Code Pro) |
| `custom.scss` | Structural theme rules, layered over `cosmo` (light) / `darkly` (dark) |
| `_quarto.yml` | Site + navbar config |
| `assets/` | Logos and images |

Colours and fonts live in `_brand.yml`. It is listed **after** the bootswatch
theme (`theme: [cosmo, brand, custom.scss]`) so its values win — `brand` is
otherwise lowest priority. The site follows the visitor's OS light/dark
preference via `respect-user-color-scheme: true`.

## Develop

Requires [Quarto](https://quarto.org/docs/get-started/) and R.

```sh
quarto preview   # live-reloading local server
quarto render    # build the full site into _site/
```

`_site/` is git-ignored — the site is **not** committed. It is rendered and
published by GitHub Actions (`.github/workflows/publish.yml`) on every push to
`main`.

> [!IMPORTANT]
> Deployment requires the repo's **Pages source** to be set to **GitHub Actions**
> (Settings → Pages → Build and deployment → Source). The `CNAME` (`animovement.dev`)
> is carried into `_site/` via the `resources:` key in `_quarto.yml`.

## Reproducibility

Package versions are pinned with [renv](https://rstudio.github.io/renv/)
(`renv.lock`). The lockfile currently pins the R version, the r-universe + CRAN
repositories, and renv itself. When tutorials become executable (see below), add
the ecosystem packages to the lockfile once:

```r
renv::install(c(
  "animovement", "aniframe", "aniread", "anicheck",
  "aniprocess", "animetric", "anivis", "ggplot2"
))
renv::snapshot()
```

## Tutorials

Tutorials live in `learn/` and use Quarto authoring features (tabsets, callouts,
cross-references, and `freeze`). Code blocks are currently display-only; when
bundled example data is available, make the chunks executable so the validation
job exercises them.

`.github/workflows/validate.yml` re-renders `learn/` against the **latest**
published package versions (freeze disabled via the `validate` profile,
`_quarto-validate.yml`) on a weekly schedule and on each ecosystem release, so a
breaking API change fails loudly.

## Package sites

The per-package pkgdown sites live in separate repositories. To give them the
same shared navbar (Learn + Packages dropdown) as this hub, see
[`docs/pkgdown-navbar.md`](docs/pkgdown-navbar.md).
