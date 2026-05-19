# Workaround for vscode-R attach issue with R 4.6.0.
# https://github.com/REditorSupport/vscode-R/issues/1696

if (interactive()) {
  init_path <- file.path(Sys.getenv("HOME"), ".vscode-R", "init.R")

  if (file.exists(init_path)) {
    try(source(init_path), silent = TRUE)

    if (exists(".First.sys", mode = "function")) {
      try(.First.sys(), silent = TRUE)
    }
  }
}

if (interactive() && requireNamespace("httpgd", quietly = TRUE)) {
  options(vsc.use_httpgd = TRUE)
}