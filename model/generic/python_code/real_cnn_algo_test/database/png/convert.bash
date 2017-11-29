#!bash

find -name '*.png' -print0 | xargs -0 -r mogrify -format ppm
