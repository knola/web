#!/bin/bash
# Render markdown and prepare public file tree, prior to deploy.sh.
# Requires Node.js for marked tool: https://nodejs.org/en/download/

set -e

if [[ ! -d content ]]; then
  echo >&2 "Unable to find Knola sources"
  exit 1
fi
if [[ ! -x tools/marked ]]; then
  echo >&2 "Unable to find marked tool"
  exit 1
fi

rm -rf _public
mkdir -p _build _public _public/_resources

for file in content/*.md; do
  base=$(basename ${file%.md})
  doc=_build/${base}.html
  path=$base
  if [[ "$base" == "index" ]]; then
    path=""
  fi

  sed -e "s,CANONICAL,https://knola.co/$path," content/header.html > $doc
  tools/marked $file >> $doc
  cat content/footer.html >> $doc
  ln $doc _public/$base 
done

ln content/logo.svg _public/_resources/logo.svg 
ln content/style.css _public/_resources/style.css
ln app.yaml _public/app.yaml