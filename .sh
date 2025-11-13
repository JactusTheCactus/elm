#!/usr/bin/env bash
set -euo pipefail
flag() {
	for f in "$@"; do
		[[ -e ".flags/$f" ]] || return 1
	done
}
tsc
node dist/pug.js
sass src/style.scss style.css
elm make src/Main.elm --output=elm.js