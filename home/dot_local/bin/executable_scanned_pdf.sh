#!/bin/sh
# needs ImageMagick
# and
#   <policy domain="coder" rights="read | write" pattern="PDF" />
# inside /etc/ImageMagick-7/policy.xml

convert -density 150 "$1" -colorspace gray -linear-stretch 2.5%x7% -blur 0x0.1 -attenuate 0.1 +noise Gaussian -contrast -constrast "$2"
