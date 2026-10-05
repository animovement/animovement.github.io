options(
  cli.num_colors = 256,
  crayon.enabled = TRUE
)

fansi::set_knit_hooks(
  knitr::knit_hooks,
  which = c("output", "message", "warning", "error")
)
