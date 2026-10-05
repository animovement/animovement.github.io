# Incoming tutorials

Raw transfer of the ecosystem tutorials that used to live in
[`animovement/animovement`](https://github.com/animovement/animovement) under
`vignettes/articles/`, moved here as part of
[animovement#148](https://github.com/animovement/animovement/issues/148) so the
package site can be scoped to the metapackage itself.

Copied verbatim from `animovement@98f62dd` — **not yet adapted to this site**.
The leading underscore keeps Quarto from rendering this directory, so nothing
here affects the build until it is refined and moved into place.

## What is here

The hub's own `learn/` placeholder pages have since been removed, so nothing
here is superseded — these drafts are the only tutorial material we have.

| file | destination | hub equivalent | notes |
| --- | --- | --- | --- |
| `learn/read-trackball.Rmd` | `learn/` | none | no trackball tutorial on the hub yet |
| `learn/trackball.qmd` | `learn/` | none | end-to-end trackball workflow |
| `learn/calculate-summary-statistics.Rmd` | `learn/` | none | no summary-statistics tutorial yet |
| `learn/batch-processing.qmd` | `learn/` | none | |
| `learn/calculate-kinematics.Rmd` | `learn/` | none | |
| `learn/clean-tracks.Rmd` | `learn/` | none | |
| `learn/deeplabcut.qmd` | `learn/` | none | |
| `about/mission.qmd` | `about/` | — | |
| `contribute/roadmaps.qmd` | `contribute/` | — | |
| `learn/_setup.R` | — | — | knitr hooks the `.Rmd` files source as `../_setup.R` |

## Known staleness

These were written against the pre-split monolithic API and were never updated,
which is why they are being moved rather than linked. Dead calls to fix while
refining:

- `filter_aniframe` — `calculate-kinematics`, `calculate-summary-statistics`,
  `clean-tracks`, `deeplabcut`, `trackball`
- `check_outliers`, `smooth_tracks` — `clean-tracks`
- `clean_tracks()`, `clean_kinematics()`, `calculate_statistics()` — referenced
  in `about/mission.qmd`

`batch-processing.qmd` and `contribute/roadmaps.qmd` scanned clean.
