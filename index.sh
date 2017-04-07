#!/bin/sh

svgify () {
  local image=$1
  local width=`identify -format '%w' $image`
  local height=`identify -format '%h' $image`
  local extension=`identify -format '%e' $image`
  local data="$(
    convert $image -resize 40x22 -quality 100 $extension:-\
      | openssl base64\
      | tr -d \\n
    )"
  sed "
    s~{{width}}~${width}~g
    s~{{height}}~${height}~g
    s~{{data}}~${data}~g
  " index.svg
}

if [ -z $1 ] || [ ! -f $1 ] ; then
  echo "error. i need an image."
  exit 1
else
  svgify $1
fi