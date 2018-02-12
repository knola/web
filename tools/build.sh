#!/bin/bash
# Convert markdown to HTML, prior to deploy.sh. Requires `marked':
# https://www.npmjs.com/package/marked

if [[ ! -f logo.svg ]]; then
  echo >&2 "Unable to find Knola sources"
  exit 1
fi
if [[ ! -x tools/marked ]]; then
  echo >&2 "Unable to find marked tool"
  exit 1
fi

rm -rf _public
mkdir -p _build _public _public/_resources

for file in *.md; do
  base=${file%.md}
  doc=_build/${base}.html
  cat header.html > $doc
  tools/marked $file >> $doc
  cat footer.html >> $doc
  ln $doc _public/$base 
done

ln logo.svg _public/_resources/logo.svg 
