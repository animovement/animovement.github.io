# Shared pkgdown navbar

Each package's pkgdown site (aniframe, aniread, anicheck, aniprocess, animetric,
anivis, and the animovement metapackage) should carry the same navbar as the hub,
so a reader can jump to **Get Started**, the **Learn** tutorials, or any sibling
package's reference from anywhere in the ecosystem.

Paste the block below into each package's `_pkgdown.yml` (merge with any existing
`navbar:` entries). The links are absolute so they resolve the same from every
subsite.

```yaml
template:
  bootstrap: 5

navbar:
  structure:
    left:  [intro, reference, articles]
    right: [learn, ecosystem, github]
  components:
    learn:
      text: Learn
      href: https://animovement.dev/learn/
    ecosystem:
      text: Packages
      menu:
        - text: "animovement (meta)"
          href: https://animovement.dev/animovement
        - text: "aniframe — data structures"
          href: https://animovement.dev/aniframe
        - text: "aniread — read & write"
          href: https://animovement.dev/aniread
        - text: "anicheck — data quality"
          href: https://animovement.dev/anicheck
        - text: "aniprocess — processing"
          href: https://animovement.dev/aniprocess
        - text: "animetric — metrics"
          href: https://animovement.dev/animetric
        - text: "anivis — visualization"
          href: https://animovement.dev/anivis
    github:
      icon: fab fa-github
      href: https://github.com/animovement
      aria-label: GitHub
```

Keep this list in sync with the hub navbar in [`_quarto.yml`](../_quarto.yml).
