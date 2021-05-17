#!/bin/sh

OUTPUT_DIR=_build

STYLE=material-teal
OPT_STYLE="-a stylesdir="$PWD/styles" -a stylesheet=${STYLE}.css"

rm -rf ${OUTPUT_DIR}

export TZ=Asia/Tokyo

asciidoctor \
  -r asciidoctor-diagram \
  -D ${OUTPUT_DIR} \
  -R ./ \
  ${OPT_STYLE} \
  "**/index.adoc"

exit 0
