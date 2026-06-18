#!/usr/bin/env sh
set -e

arch=$(arch)
TMP_DEST=$(mktemp -d)
FILE="${TMP_DEST}/shellcheck.tar.xz"
FINAL_DEST=~/bin/shellcheck

if [ "$arch" = "arm64" ]; then
	ARCH=aarch64
elif [ "$arch" = "x86_64" ]; then
	ARCH=x86_64
else
	echo "Unsupported architecture: $(arch)"
	exit 1
fi
URL=https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.${ARCH}.tar.xz

if command curl --version; then
	curl --output "$FILE" "$URL"
elif command wget --version; then
	wget -O "$FILE" "$URL"
else
	echo "curl or wget must be installed"
	exit 1
fi

echo "OUT: $TMP_DEST"
echo "FILE: $FILE"
tar -xf "$FILE" -C "$TMP_DEST"
cp "$TMP_DEST"/shellcheck "$FINAL_DEST"
