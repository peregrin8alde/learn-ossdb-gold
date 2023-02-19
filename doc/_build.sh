#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

SITE_DIR="${PARENT_DIR}/site"
CONTENTS_DIR="${SITE_DIR}/content/ja/docs"
INPUT_INDEXFILE="${CONTENTS_DIR}/_index.adoc"
OUTPUT_DIR="${SCRIPT_DIR}/_build"

STYLE=material-teal
OPT_STYLE="-a stylesdir="${SCRIPT_DIR}/styles" -a stylesheet=${STYLE}.css"

ATTRIBUTES_FILE="${SCRIPT_DIR}/_attributes.adoc"
OPT_ATTRIBUTES_FILE="-a attributes="${ATTRIBUTES_FILE}""

cd "${PARENT_DIR}"

rm -rf "${OUTPUT_DIR}"

asciidoctor \
  -r asciidoctor-diagram \
  -D "${OUTPUT_DIR}" \
  -R "${CONTENTS_DIR}" \
  ${OPT_STYLE} \
  ${OPT_ATTRIBUTES_FILE} \
  -a imagesdir="${SITE_DIR}/static/images" \
  -a env-asciidoctor \
  -a skip-front-matter \
  -a docinfo=shared \
  -a docinfodir="${SCRIPT_DIR}" \
  "${INPUT_INDEXFILE}"

# plantuml を使うと謎のディレクトリが作成されるため、削除
if [ -d ./\? ]; then
  rm -rf ./\?/
fi


exit 0
