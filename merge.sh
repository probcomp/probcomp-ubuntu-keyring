#!/bin/sh

set -Ceu

: ${GPG:=gpg}

gpghome=
trap 'rm -rf "$gpghome"' EXIT HUP INT TERM
gpghome="`mktemp -d merge.XXXXXX`"

for key in "$@"; do
    ${GPG} --homedir "$gpghome" --import "$key"
done

${GPG} --homedir "$gpghome" \
    --armour --no-emit-version --export-options export-clean \
    --export
