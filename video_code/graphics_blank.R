
# Fundamentals of plotting in R

#  the graphics device
#  the plot.default function
#    - type = "n"
#  points, lines, text, mtext
#  graphical parameters
#    - fonts, margins, text size

# What happens when we do this?

# all R plots are drawn on graphics devices
# ?dev.new

# on linux, the default graphics device is X11 (or x11)
# on mac, it's quartz()
# on windows, windows() [ X11() also works ]

# list all of the graphics devices

# to close the "current" device

# to close all of them (similar to the broom icon in RStudio)

# set default options with X11.options

# to save plots to a file, use one of the many graphics devices
# ?Devices


# If we are not saving a file, we don't think too much
# about the graphics device.
# We simply call one of the plotting functions
# (like "plot" or "hist"), which either:
#   1. If no graphics device is open, opens one and draws on it.
#   2. If a graphics device is open, draws on the current one

# define some functions for plotting the examples below:

# we have control over everything on the plot
# ?plot



# plotting symbols

# size of points

# points

# lines

# text - adding text to plot

# mtext - adding text to margins
# (easier to control than axis labels and titles)

# see also: polygon, rect, segments, abline, arrows

# axes and annotations

# add your own axes

# pet peeve: get rid of slightly thicker line
# ?axis


# graphical parameters - spend some time reading through the documentation
# you'll learn something!
# ?par





# Exercise: draw a clock with Hershey fonts

# initialize an empty plot
# add the numbers 1 through 12
# draw arrows for the clock hands
# add a company name


# add some decorations
