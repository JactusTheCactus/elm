#!/usr/bin/env bash
declare -A seen_ext
EXTENSIONS=()
for f in src/*; do
	ext="${f##*.}"
	[[ -z ${seen_ext[$ext]} ]] && {
		EXTENSIONS+=("$ext")
		seen_ext[$ext]=1
	}
done
mapfile -t EXTENSIONS < <(printf '%s\n' "${EXTENSIONS[@]}" | sort)
exec > elm.md
echo "# Thoughts?"
for EXT in "${EXTENSIONS[@]}"; do
	echo "## ${EXT^^}"
	FILES=()
	for i in src/*.$EXT; do
		FILES+=("$i")
	done
	mapfile -t FILES < <(printf '%s\n' "${FILES[@]}" | sort)
	for i in "${FILES[@]}"; do
		FILE="$i"
		echo "### \`${FILE#src}\`"
		echo "\`\`\`$EXT"
		cat "$FILE"
		echo "\`\`\`"
	done
done
