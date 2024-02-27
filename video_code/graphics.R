
# Fundamentals of plotting in R

#  the graphics device
#  the plot.default function
#    - type = "n"
#  points, lines, text, mtext
#  graphical parameters
#    - fonts, margins, text size

# What happens when we do this?
plot( rnorm(10), rnorm(10) )

# all R plots are drawn on graphics devices
# ?dev.new

# on linux, the default graphics device is X11 (or x11)
# on mac, it's quartz()
# on windows, windows() [ X11() also works ]
X11()
dev.new() # opens the default graphics device
dev.new( width=7, height=7, xpos = 1000, ypos = 200)

# list all of the graphics devices
dev.list()

# to close the "current" device
dev.off()
dev.list()

# to close all of them (similar to the broom icon in RStudio)
graphics.off()
dev.list()

# set default options with X11.options
X11.options( xpos = 1000, ypos = 200 )
X11()
X11.options( reset = TRUE )
X11()
X11.options( xpos = 1000, ypos = 200 )
graphics.off()
plot( rnorm(10), rnorm(10) )

# to save plots to a file, use one of the many graphics devices
# ?Devices
pdf("plot1.pdf", width = 7, height = 7 )
dev.cur()
plot( rnorm(10), rnorm(10) )
dev.off() # this closes the graphics device and saves the file

jpeg("plot1.jpeg", width = 700, height = 700 )
plot( rnorm(10), rnorm(10) )
dev.off() # this closes the graphics device and saves the file

# If we are not saving a file, we don't think too much
# about the graphics device.
# We simply call one of the plotting functions
# (like "plot" or "hist"), which either:
#   1. If no graphics device is open, opens one and draws on it.
#   2. If a graphics device is open, draws on the current one

# define some functions for plotting the examples below:
circle_points <- function( n = 12, noise = 0.1 ){
    theta <- 2*pi*seq(0,1,length.out=n+1)[-1]
    x1 <- cos(theta) + noise*rnorm( n )
    x2 <- sin(theta) + noise*rnorm( n )
    return( list( x1=x1, x2=x2 ) )
}
circ <- circle_points()
x1 <- circ$x1
x2 <- circ$x2

# we have control over everything on the plot
# ?plot
plot( x1, x2 )
plot( x1, x2, type = "l")
plot( x1, x2, type = "b")
plot( x1, x2, type = "c")
plot( x1, x2, type = "o")
plot( x1, x2, type = "n") # useful if you want to set up the axes before adding elements

plot( x1, x2, xlim = c(-2,2) )
plot( x1, x2, xlim = c(-2,2), ylim = c(-2,2) )

plot( x1, x2, xlab = "horizontal position (cm)",
              ylab = "vertical position (cm)" )

# plotting symbols
plot( x1, x2, pch = 1 ) # default plotting symbol
plot( x1, x2, pch = 2 )
plot( x1, x2, pch = 1:2 )
plot( x1, x2, pch = 0:16 )

# size of points
plot( x1, x2, cex = 2 )
plot( x1, x2, cex = 0.7, pch = 0 )

# points
plot( x1, x2, xlim = c(-1.5,1.5), ylim = c(-1.5,1.5) )
circ <- circle_points()
points( circ$x1, circ$x2, pch = 2 )
circ <- circle_points()
points( circ$x1, circ$x2, pch = 3 )
circ <- circle_points()
points( circ$x1, circ$x2, pch = 4 )

# lines
plot( c(x1,x1[1]), c(x2,x2[1]),
     xlim = c(-1.5,1.5), ylim = c(-1.5,1.5), type = "l" )
circ <- circle_points()
lines( c(circ$x1,circ$x1[1]), c(circ$x2,circ$x2[1]), col = "magenta")
circ <- circle_points()
lines( c(circ$x1,circ$x1[1]), c(circ$x2,circ$x2[1]), col = "blue")
circ <- circle_points()
lines( c(circ$x1,circ$x1[1]), c(circ$x2,circ$x2[1]), col = "darkgreen")

# text - adding text to plot
plot( x1, x2, xlim = c(-1.5,1.5), ylim = c(-1.5,1.5) )
text( x1, x2 - 0.1, LETTERS[1:12] )

# mtext - adding text to margins
# (easier to control than axis labels and titles)
plot( x1, x2, xlim = c(-1.5,1.5), ylim = c(-1.5,1.5) )
mtext( "Extremely Important Data", side = 3, line = 0 )
mtext( "You should pay attention to this", side = 3, line = 1.5, font = 2, cex = 1.5 )

# see also: polygon, rect, segments, abline, arrows

# axes and annotations
plot( x1, x2, axes = FALSE )
plot( x1, x2, ann = FALSE )

# add your own axes
plot( x1, x2, axes = FALSE )
axis(1, at = -1:1, labels = c("left","center","right") )
axis(2, at = seq(-1,1,by=0.1))
box()

# pet peeve: get rid of slightly thicker line
# ?axis
plot( x1, x2, axes = FALSE )
axis(1, lwd = 0, lwd.ticks = 1)
axis(2, lwd = 0, lwd.ticks = 1)
box()


# graphical parameters - spend some time reading through the documentation
# you'll learn something!
# ?par
par( mfrow=c(2,2) )
plot( x1, x2 )
plot( x1, x2 )
plot( x1, x2 )
plot( x1, x2 )
plot( x1, x2 )

dev.off()

par( col = "gray", col.axis = "magenta", pch = 4, mar = c(6,6,1,1) )
plot( x1, x2 )



# Exercise: draw a clock with Hershey fonts

# initialize an empty plot
par( mar = c(0,0,0,0) )
plotsize <- 1.5
plot(0,
   type = "n",
   xlim = plotsize*c(-1,1), ylim = plotsize*c(-1,1),
   axes = FALSE, ann = FALSE
)
# add the numbers 1 through 12
circ <- circle_points( n = 12, noise = 0 )
x1 <- circ$x1
x2 <- circ$x2
nums <- c( 2,1, 12:3 )
text( x1, x2, nums, cex = 3.0, vfont = c("serif","bold" ) )
?Hershey
# draw arrows for the clock hands
hour_fac <- 0.7
min_fac <- 0.85
points(0,0, pch = 16, cex = 4 )
arrows(
    x0=0, y0=0,
    x1 = hour_fac*cos(2*pi*5/12), y1 = hour_fac*sin(2*pi*5/12),
    lwd = 8,
    lend = 1,
    ljoin = 1
)
arrows(
    x0=0, y0=0,
    x1 = min_fac*cos(2*pi*1/12), y1 = min_fac*sin(2*pi*1/12),
    lwd = 4,
    lend = 1,
    ljoin = 1
)
# add a company name
text( 0, 0.5, "WatchCo", vfont = c("serif", "plain" ), cex = 1.75 )
rectsize <- 1.25
rect( -rectsize, -rectsize, rectsize, rectsize,
     border = 2, lwd = 12 )


# add some decorations
