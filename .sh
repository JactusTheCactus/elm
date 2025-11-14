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
mkdir -p src/{bak,tmp}
ELM=src/Main.elm
TMP=src/tmp/Main.elm
BAK=src/bak/Main.elm
cp $ELM $BAK
if $(perl -0777 -pe '
	s/\n{2,}/\n/g;
    s/(?<=\b0x)0+(?=[0-9A-F]+\b)//g;
' $ELM > $TMP) && [[ -s $TMP ]]; then
	mv $TMP $ELM
	elm make $ELM --output=elm.js
else
	cp $BAK $ELM
	echo "RegEx Clean Error!" >&2
fi
rm -rf src/bak
rm -rf src/tmp