#!/bin/bash

TARFILE=/tmp/nt.tar
INFILE="$HOME/nt.txz"
OUTFILE="$HOME/nt.txz.enc"
DESTINATION=termysequence.com:bax/
EXCLUDES=/tmp/nt.excludes

cat <<EOF >$EXCLUDES
termysequence/build
termysequence/vendor/v8-linux
termysequence/vendor/termy-emoji
termysequence/vendor/termy-icon-theme
termy-doc/_build
termy-website/_build
__pycache__
*.tar.*
*~
.#*
*.bak
*.orig
*.rej
*.swp
.directory
EOF

cd "$HOME/git"
rm -f $TARFILE

if ! tar cf "$TARFILE" --exclude-from=$EXCLUDES termysequence; then
    echo 'Problem running tar, bailing out' 1>&2
    exit 1
fi
if ! tar rf "$TARFILE" --exclude-from=$EXCLUDES termy-doc; then
    echo 'Problem running tar, bailing out' 1>&2
    exit 1
fi
if ! tar rf "$TARFILE" --exclude-from=$EXCLUDES termy-website; then
    echo 'Problem running tar, bailing out' 1>&2
    exit 1
fi

cd "$HOME"
if ! tar rf "$TARFILE" patches util .ssh .gnupg; then
    echo 'Problem running tar, bailing out' 1>&2
    exit 1
fi

if ! xz <"$TARFILE" >"$INFILE"; then
    echo 'Problem running xz, bailing out' 1>&2
    exit 1
fi
if ! openssl enc -aes256 -in "$INFILE" -out "$OUTFILE"; then
    echo 'Problem running openssl, bailing out' 1>&2
    exit 2
fi

chmod 600 "$OUTFILE"
scp "$OUTFILE" "$DESTINATION"
if [ $? -ne 0 ]; then
    echo 'Upload failed!' 1>&2
    exit 3
fi

echo 'Backup operation succeeded'
