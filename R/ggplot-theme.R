# code source:
# https://drsimonj.svbtle.com/creating-corporate-colour-palettes-for-ggplot2

# eaaa corporate colors
eaaa_colors <- c(
  "pink"         = rgb(218, 187, 190, max = 255),
  "red"          = rgb(170, 39, 47, max = 255),
  "blue"         = rgb(0, 131, 169, max = 255),
  "dark blue"    = rgb(0, 33, 71, max = 255),
  "light green"  = rgb(157, 188, 176, max = 255),
  "green"        = rgb(44, 94, 79, max = 255),
  "yellow"       = rgb(235, 221, 156, max = 255),
  "orange"       = rgb(225, 112, 0, max = 255),
  "purple"       = rgb(90, 68, 122, max = 255),
  "dark purple"  = rgb(83, 46, 96, max = 255),
  "grey"         = rgb(68, 105, 125, max = 255),
  "dark grey"    = rgb(129, 138, 143, max = 255),
  "light brown"  = rgb(183, 98, 27, max = 255),
  "dark brown"   = rgb(93, 53, 38, max = 255),
  "olive"        = rgb(206, 214, 75, max = 255),
  "light blue"   = rgb(63, 207, 21, max = 255),
  "light grey"   = rgb(224, 230, 230, max = 255),
  "light blue"   = rgb(131, 175, 180, max = 255),
  "dark red"     = rgb(151, 35, 63, max = 255)
  )

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
  `qual`  = eaaa_cols("red", "blue", "green", "purple", "orange", "yellow",
                      "dark brown", "pink", "grey"),
  `paired`  = eaaa_cols("pink", "red",
                      "blue", "dark blue",
                      "light green", "green",
                      "purple", "dark purple",
                      "yellow", "orange",
                      "light brown", "dark brown",
                      "grey", "dark grey"),
  `blues` = eaaa_cols("blue", "dark blue"),
  `cool`  = eaaa_cols("blue", "green"),
  `hot`   = eaaa_cols("yellow", "orange", "red"),
  `grey`  = eaaa_cols("light grey", "dark grey")
)


#' Return function to interpolate a eaaa color palette
#'
#' @param palette Character name of palette in eaaa_palettes
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#'
eaaa_pal <- function(palette = "qual", discrete = TRUE, reverse = FALSE, ...) {
  pal <- eaaa_palettes[[palette]]

  if (reverse) pal <- rev(pal)
  if (!discrete) {
    pal <- colorRampPalette(pal, ...)
    }
  pal
}


#' Color scale constructor for eaaa colors
#'
#' @param palette Character name of palette in eaaa_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_color_gradientn(), used respectively when discrete is TRUE or FALSE
#'
scale_color_eaaa <- function(palette = "qual", discrete = TRUE, reverse = TRUE, ...) {
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
scale_fill_eaaa <- function(palette = "qual", discrete = TRUE, reverse = TRUE, ...) {
  pal <- eaaa_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("fill", paste0("eaaa_", palette), palette = pal, ...)
  } else {
    scale_fill_gradientn(colours = pal(256), ...)
  }
}

