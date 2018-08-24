#
#  EES 3310 Lab Utility Scripts
#
library(stringr)

sb_const <- 5.6704E-8
zero_celsius <- 273.15 # K

base_methane_ppm <- 1.7 # parts per billion
base_co2_ppm <- 400 # parts per million

solar_constant <- 1350 # W/m^2
r_earth <- 6.378E+6 # meters

albedo_earth <- 0.30
albedo_mars <- 0.17
albedo_venus <- 0.71

T_surf_earth <- 295
T_surf_mars <- 240
T_surf_venus <- 700

au_earth <- 1.00
au_mars <- 1.50
au_venus <- 0.72

elr_earth <- 6 # K/km
alr_dry <- 10

bare_rock <- function(solar_const = solar_constant, albedo = 0.30, au = 1, emissivity = 1) {
  # default solar constant is for earth.
  # scale to other planets by 1 / r^2, where R is the average radius of the orbit
  # around the sun, in astronomical units. R_earth is 1 AU
  solar_const <-   solar_const / au^2
  absorbed_shortwave <- (1 - albedo) * solar_const / 4
  temperature <- (absorbed_shortwave / (emissivity * sb_const))^0.25
  temperature
}

sc_earth <- solar_constant
sc_venus <- solar_constant / au_venus^2
sc_mars <- solar_constant / au_mars^2

tbr_earth <- bare_rock(sc_earth, albedo_earth)
tbr_mars  <- bare_rock(sc_earth, albedo_mars, au_mars)
tbr_venus <- bare_rock(sc_earth, albedo_venus, au_venus)

# Functions for converting temperatures

ftoc <- function(x) {
  (x - 32) * 5./9.
}

ctof <- function(x) {
  x * 9./5. + 32.
}

ktoc <- function(x) {
  x - zero_celsius
}

ctok <- function(x) {
  x + zero_celsius
}

ftok <- function(x) {
  ctok(ftoc(x))
}

ktof <- function(x) {
  ctof(ktoc(x))
}
