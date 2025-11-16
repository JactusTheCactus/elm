#!/usr/bin/env bash
# TODO:
# FIGURE OUT SORTING ARRAYS
contains() {
	for i in "$@"; do
		[[ "$1" == "$i" ]] && return 0
	done
	return 1
}
EXTENSIONS=()
for f in src/*; do
	f="${f#*.}"
	if ! contains "$f" "${EXTENSIONS[@]}"; then
		EXTENSIONS+=("$f")
	fi
done
# SORT ${EXTENSIONS[@]}
exec > elm.md
echo "# Thoughts?"
for EXT in "${EXTENSIONS[@]}"; do
	echo "## ${EXT^^}"
	FILES=()
	for i in src/*.$EXT; do
		FILES+=("$i")
	done
	# SORT ${FILES[@]}
	for i in "${FILES[@]}"; do
		FILE="$i"
		echo "### \`${FILE#src}\`"
		echo "\`\`\`$EXT"
		cat "$FILE"
		echo "\`\`\`"
	done
done
