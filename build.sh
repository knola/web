#!/bin/bash
# Convert markdown to HTML, prior to deploy.sh. Requires `marked':
# https://www.npmjs.com/package/marked

mkdir -p _build

for file in *.md; do
  doc=_build/${file%.md}.html
  cat header.html > $doc
  marked $file >> $doc
  cat footer.html >> $doc
done
