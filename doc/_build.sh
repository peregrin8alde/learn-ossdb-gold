#!/bin/sh

OUTPUT_DIR=_build
DOCBASE_DIR=/documents

STYLE=material-teal
OPT_STYLE="-a stylesdir="${DOCBASE_DIR}/styles" -a stylesheet=${STYLE}.css"

rm -rf ${OUTPUT_DIR}

docker run \
  -u $(id -u):$(id -g) \
  --rm \
  -v "$(pwd):${DOCBASE_DIR}" \
  -e TZ=Asia/Tokyo \
  asciidoctor/docker-asciidoctor \
    asciidoctor \
      -r asciidoctor-diagram \
      -D ${OUTPUT_DIR} \
      -R ./ \
      ${OPT_STYLE} \
      "**/index.adoc"

exit 0
