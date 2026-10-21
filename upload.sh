#!/bin/sh
# Publishes the release repository and the 0.90.32 beta archives to GitHub (WaveboSF/UpScape).
# Needs: gh installed and logged in as WaveboSF (gh auth status). Run from this folder.
# Step 1 creates the public repository from this folder and pushes main; step 2 creates the
# release v0.90.32-beta with the three archives and their .sha256 files as assets.
set -eu
HERE=$(cd "$(dirname "$0")" && pwd)
DIST=${UPSCAPE_DIST:-/mnt/development/UpScape_Rust/dist}
V=0.90.32-beta
for f in UpScape-$V-linux-x86_64.tar.gz UpScape-$V-windows-x86_64.zip UpScape-$V-models-onnx.zip; do
    [ -f "$DIST/$f" ] || { echo "missing $DIST/$f" >&2; exit 1; }
    (cd "$DIST" && sha256sum -c "$f.sha256")
done
gh auth status
if ! gh repo view WaveboSF/UpScape >/dev/null 2>&1; then
    gh repo create WaveboSF/UpScape --public --source="$HERE" --remote=origin --push \
        --description "AI image enlargement for SEM images and photographs - native Rust desktop program"
else
    git -C "$HERE" remote get-url origin >/dev/null 2>&1 || git -C "$HERE" remote add origin https://github.com/WaveboSF/UpScape.git
    git -C "$HERE" push -u origin main
fi
gh release create "v$V" --repo WaveboSF/UpScape --title "UpScape $V" --prerelease \
    --notes-file "$HERE/docs/RELEASE_NOTES_0.90.32-beta.md" \
    "$DIST/UpScape-$V-linux-x86_64.tar.gz" "$DIST/UpScape-$V-linux-x86_64.tar.gz.sha256" \
    "$DIST/UpScape-$V-windows-x86_64.zip" "$DIST/UpScape-$V-windows-x86_64.zip.sha256" \
    "$DIST/UpScape-$V-models-onnx.zip" "$DIST/UpScape-$V-models-onnx.zip.sha256"
gh release view "v$V" --repo WaveboSF/UpScape
