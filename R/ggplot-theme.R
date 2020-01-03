# code source:
# https://drsimonj.svbtle.com/creating-corporate-colour-palettes-for-ggplot2

# eaaa corporate colors
eaaa_colors <- c(
  `pink`         = "#DABBBE",
  `red`          = "#AA272F",
  `light green`  = "#CED64B",
  `green`        = "#2C5E4F",
  `light blue`   = "#83AFB4",
  `blue`         = "#0083A9",
  `light purple` = "#E17000",
  `purple`       = "#5A447A",
  `yellow`       = "#EBDD9C",
  `orange`       = "#E17000",
  `light brown`  = "#B7621B",
  `brown`        = "#5D3526",
  `light grey`   = "#E0E6E6",
  `dark grey`    = "#818A8F")


#' Function to extract eaaa colors as hex codes
#'
#' @param ... Character names of eaaa_colors
#'
eaaa_cols <- function(...) {
  cols <- c(...)

  if (is.null(cols))
    return (eaaa_colors)

  eaaa_colors[cols]
}


eaaa_palettes <- list(
  `main`  = eaaa_cols("red", "blue", "green"),

  `cool`  = eaaa_cols("blue", "green"),

  `hot`   = eaaa_cols("yellow", "orange", "red"),

  `mixed` = eaaa_cols("blue", "green", "yellow", "orange", "red"),

  `grey`  = eaaa_cols("light grey", "dark grey")
)


#' Return function to interpolate a eaaa color palette
#'
#' @param palette Character name of palette in eaaa_palettes
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#'
eaaa_pal <- function(palette = "main", reverse = TRUE, ...) {
  pal <- eaaa_palettes[[palette]]

  if (reverse) pal <- rev(pal)

  colorRampPalette(pal, ...)
}


#' Color scale constructor for eaaa colors
#'
#' @param palette Character name of palette in eaaa_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_color_gradientn(), used respectively when discrete is TRUE or FALSE
#'
scale_color_eaaa <- function(palette = "main", discrete = TRUE, reverse = TRUE, ...) {
  pal <- eaaa_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("colour", paste0("eaaa_", palette), palette = pal, ...)
  } else {
    scale_color_gradientn(colours = pal(256), ...)
  }
}

#' Fill scale constructor for eaaa colors
#'
#' @param palette Character name of palette in eaaa_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_fill_gradientn(), used respectively when discrete is TRUE or FALSE
#'
scale_fill_eaaa <- function(palette = "main", discrete = TRUE, reverse = TRUE, ...) {
  pal <- eaaa_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("fill", paste0("eaaa_", palette), palette = pal, ...)
  } else {
    scale_fill_gradientn(colours = pal(256), ...)
  }
}

