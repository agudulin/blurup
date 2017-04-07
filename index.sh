#!/bin/sh

svgify () {
  local image, width, height, extension, data

  image=$1
  width=$(identify -format '%w' "$image")
  height=$(identify -format '%h' "$image")
  extension=$(identify -format '%e' "$image")
  data="$(
    convert "$image" -resize 40x22 -quality 100 "$extension":-\
      | openssl base64\
      | tr -d \\n
    )"
  sed "
    s~{{width}}~${width}~g
    s~{{height}}~${height}~g
    s~{{data}}~${data}~g
  " index.svg
}

if [ -z "$1" ] || [ ! -f "$1" ] ; then
  echo "error. i need an image."
  exit 1
else
  svgify "$1"
fi