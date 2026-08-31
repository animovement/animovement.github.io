# animovement.dev

The [Quarto](https://quarto.org) website behind [animovement.dev](https://animovement.dev):
the marketing front page **and** the central home for cross-package learning
tutorials. Each individual package keeps its own pkgdown reference site at
`animovement.dev/<package>`; this hub is for the pitch, get-started, and
**end-to-end, cross-package** workflows.

## Structure

| Path | Contents |
| --- | --- |
| `index.qmd` | Landing page (custom hero + package hex grid) |
| `packages/` | The package ecosystem, linking to each pkgdown site |
| `get-started/` | Get Started — install, read, check, process, measure (executable) |
| `learn/` | Learn landing page (tutorials to come) |
| `help/` | Getting help — issues, discussions, contributing |
| `about/`, `contribute/` | About and Contribute pages |
| `_brand.yml` | Central brand: accent colour (teal) + fonts (Lato / Source Code Pro) |
| `_quarto.yml` | Site + navbar config |
| `assets/images/` | Logos and images (incl. the honeycomb background) |
| `assets/logos/` | Per-package hex stickers (`<package>.svg`) |
| `assets/scss/` | Theme styling — `custom.scss` + per-theme `navbar-{light,dark}.scss` |

Colours and fonts live in `_brand.yml`. It is listed **after** the bootswatch
theme (`theme: [cosmo, brand, assets/scss/custom.scss]`) so its values win —
`brand` is otherwise lowest priority. The site follows the visitor's OS
light/dark preference via `respect-user-color-scheme: true`.

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
repositories, renv itself, and the animovement ecosystem — the Get Started
guides execute their code at render time, so `renv::restore()` is enough to
build the site. To add or refresh the ecosystem in the lockfile:

```r
renv::install(c(
  "animovement", "anicore", "aniread", "anicheck", "aniprocess",
  "animetric", "anivis", "anispace", "ggplot2",
  # suggested packages the guides exercise
  "signal", "circular", "bioc::rhdf5"
))
renv::snapshot()
```

## Guides and tutorials

The **Get Started** guides in `get-started/` execute their R code at render
time against the packages in `renv.lock`, so the printed output and figures on
the site are real. Rendering them needs the ecosystem installed
(`renv::restore()` does it), including the suggested packages `rhdf5` (HDF5
exports), `signal` (Savitzky-Golay) and `circular` (circular summaries).
Executed output is cached in `_freeze/`, which **is committed** — the deploy
job renders from it rather than re-running R.

`learn/` currently holds only its landing page. The earlier placeholder pages
were removed rather than left half-written; real tutorials go back in once
there are complete, end-to-end workflows to show. When they return, add
`learn/` alongside `get-started/` in the validation workflow's render step.

`.github/workflows/validate.yml` re-renders `get-started/` against the
**latest** published package versions (freeze disabled via the `validate`
profile, `_quarto-validate.yml`) on a weekly schedule and on each ecosystem
release, so a breaking API change fails loudly.

## Package sites

The per-package pkgdown sites live in separate repositories and are reached at
`animovement.dev/<package>`; the hub links out to them from the navbar and the
Packages page.
