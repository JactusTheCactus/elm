#!/usr/bin/env bash
set -euo pipefail
flag() {
	for f in "$@"; do
		[[ -e ".flags/$f" ]] || return 1
	done
}
tsc
node dist/pug.js
sass --no-source-map src/style.scss style.css
perl -0777 -pe '
    s/\n{2,}/\n/g;
    s/(?<=\b0x)0+(?=[0-9A-F]{1,4}\b)//g;
' src/Main.elm > src/Main.bak.elm
elm make src/Main.elm --output=elm.js