# Show a document from animovement/.github on a page of this site, fetched at
# build time so it is only ever maintained in one place.
shared_doc <- function(file) {
  lines <- readLines(
    paste0("https://raw.githubusercontent.com/animovement/.github/main/", file),
    warn = FALSE,
    encoding = "UTF-8"
  )

  # The page title stands in for the document's own top-level heading
  lines <- lines[-seq_len(match(TRUE, grepl("^# ", lines)))]

  # GitHub alerts (> [!WARNING] ...) become Quarto callouts
  out <- character()
  i <- 1
  while (i <= length(lines)) {
    alert <- regmatches(lines[i], regexec("^> \\[!([A-Z]+)\\]\\s*$", lines[i]))[[1]]
    if (length(alert) == 2) {
      type <- switch(
        alert[2],
        WARNING = "warning",
        CAUTION = "caution",
        IMPORTANT = "important",
        TIP = "tip",
        "note"
      )
      body <- character()
      i <- i + 1
      while (i <= length(lines) && grepl("^>", lines[i])) {
        body <- c(body, sub("^> ?", "", lines[i]))
        i <- i + 1
      }
      out <- c(out, sprintf("::: {.callout-%s}", type), body, ":::")
    } else {
      out <- c(out, lines[i])
      i <- i + 1
    }
  }

  # Links between the shared documents stay on this site
  pages <- c(
    "CONTRIBUTING.md" = "guide.qmd",
    "AI.md" = "ai-policy.qmd",
    "CODE_OF_CONDUCT.md" = "code-of-conduct.qmd"
  )
  for (doc in names(pages)) {
    out <- gsub(
      paste0("https://github.com/animovement/.github/blob/main/", doc),
      pages[[doc]],
      out,
      fixed = TRUE
    )
  }

  knitr::asis_output(paste(enc2utf8(out), collapse = "\n"))
}
