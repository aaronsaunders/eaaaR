# code source:
# https://drsimonj.svbtle.com/creating-corporate-colour-palettes-for-ggplot2

# drsimonj corporate colors
drsimonj_colors <- c(
  `red`        = "#d11141",
  `green`      = "#00b159",
  `blue`       = "#00aedb",
  `orange`     = "#f37735",
  `yellow`     = "#ffc425",
  `light grey` = "#cccccc",
  `dark grey`  = "#8c8c8c")


#' Function to extract drsimonj colors as hex codes
#'
#' @param ... Character names of drsimonj_colors
#'
drsimonj_cols <- function(...) {
  cols <- c(...)

  if (is.null(cols))
    return (drsimonj_colors)

  drsimonj_colors[cols]
}

drsimonj_cols()
#>        red      green       blue     orange     yellow light grey
#>  "#d11141"  "#00b159"  "#00aedb"  "#f37735"  "#ffc425"  "#cccccc"
#>  dark grey
#>  "#8c8c8c"

drsimonj_cols("red")
#>       red
#> "#d11141"

drsimonj_cols("red", "blue")
#>       red      blue
#> "#d11141" "#00aedb"

drsimonj_cols("blue", "red")
#>      blue       red
#> "#00aedb" "#d11141"

ggplot(mtcars, aes(hp, mpg)) +
  geom_point(color = drsimonj_cols("red"),
             size = 4, alpha = .8)

drsimonj_palettes <- list(
  `main`  = drsimonj_cols("blue", "green", "yellow"),

  `cool`  = drsimonj_cols("blue", "green"),

  `hot`   = drsimonj_cols("yellow", "orange", "red"),

  `mixed` = drsimonj_cols("blue", "green", "yellow", "orange", "red"),

  `grey`  = drsimonj_cols("light grey", "dark grey")
)


#' Return function to interpolate a drsimonj color palette
#'
#' @param palette Character name of palette in drsimonj_palettes
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#'
drsimonj_pal <- function(palette = "main", reverse = FALSE, ...) {
  pal <- drsimonj_palettes[[palette]]

  if (reverse) pal <- rev(pal)

  colorRampPalette(pal, ...)
}

drsimonj_pal("cool")
#> function (n)
#> {
#>     x <- ramp(seq.int(0, 1, length.out = n))
#>     if (ncol(x) == 4L)
#>         rgb(x[, 1L], x[, 2L], x[, 3L], x[, 4L], maxColorValue = 255)
#>     else rgb(x[, 1L], x[, 2L], x[, 3L], maxColorValue = 255)
#> }
#> <bytecode: 0x7fd7e497ba38>
#> <environment: 0x7fd7e497af78>

drsimonj_pal("cool")(10)
#>  [1] "#00AEDB" "#00AECC" "#00AEBE" "#00AFAF" "#00AFA1" "#00AF92" "#00B084"
#>  [8] "#00B075" "#00B067" "#00B159"

#' Color scale constructor for drsimonj colors
#'
#' @param palette Character name of palette in drsimonj_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_color_gradientn(), used respectively when discrete is TRUE or FALSE
#'
scale_color_drsimonj <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- drsimonj_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("colour", paste0("drsimonj_", palette), palette = pal, ...)
  } else {
    scale_color_gradientn(colours = pal(256), ...)
  }
}

#' Fill scale constructor for drsimonj colors
#'
#' @param palette Character name of palette in drsimonj_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_fill_gradientn(), used respectively when discrete is TRUE or FALSE
#'
scale_fill_drsimonj <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- drsimonj_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("fill", paste0("drsimonj_", palette), palette = pal, ...)
  } else {
    scale_fill_gradientn(colours = pal(256), ...)
  }
}

# Color by discrete variable using default palette
ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Species)) +
  geom_point(size = 4) +
  scale_color_drsimonj()

# Color by numeric variable with cool palette
ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Sepal.Length)) +
  geom_point(size = 4, alpha = .6) +
  scale_color_drsimonj(discrete = FALSE, palette = "cool")

# Fill by discrete variable with different palette + remove legend (guide)
ggplot(mpg, aes(manufacturer, fill = manufacturer)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_drsimonj(palette = "mixed", guide = "none")

