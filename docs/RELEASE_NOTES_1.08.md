# UpScape 1.08

UpScape is a desktop image upscaler for Windows and Linux. Blend combines AI,
classical filters and the original; Variants makes model and blend comparisons
easier. Photos, object images and microscopy images are supported use cases.

## New since 1.01

The offline baseline now includes seven redistributable weight files and six
prepared model bundles, with complete dependency notices and model credits.
GPU/DirectML handling and CPU resource limits have improved. Eight saved setups,
an updated Batch workbench with thumbnails, easier ROI/cropping and transparent
cutouts, flexible Save naming/formats and the larger watermark editor make the
image workflow more direct. Info > System info shows requirements, detected
components and next steps; window-state handling has also improved.

- Automatic Tile adapts GPU tiles to available memory and remembers successful sizes.
- Improved Image Adjustments with synchronized previews and a Color tune switch.
- Setup offers an update of the existing installation and quietly supports offline use.
- Exact output width and height with AR on/off, within 1–4× of the current
  image or crop; optional pixel targets shared by all Batch files.
- Batch previews up to 128 megapixels, retaining the current Classical, AI or
  Compare view and the prepared processing settings.
- Save, Save as and Copy toolbar icons, available as soon as an image is open.
- A smaller, more responsive factor slider and a separate System info window
  with readable tables that adapt to the window width.

## Downloads

- `UpScape-1.08-windows-x64-setup.exe`: native x64 Windows installer, CPU/DirectML.
- `UpScape-1.08-linux-x86_64.tar.gz`: Linux x86-64, CPU/optional NVIDIA CUDA.
- Each package has a matching `.sha256` file.

The public repository contains downloads, documentation and notices; the
application source remains private. No separate model pack or Python is needed.
See [installation requirements](https://github.com/WaveboSF/UpScape/blob/main/INSTALL.md).

## System requirements and model licences

Linux needs glibc 2.43+; optional GPU execution needs NVIDIA CUDA 13 and cuDNN 9.
Windows uses DirectML with a compatible DirectX 12 adapter; its installer is
unsigned. Linux AMD/Intel GPU compute, Windows CUDA and macOS builds are not
included. On Wayland, use Open image rather than drag-and-drop.

Remacri/UltraSharp remain optional NonCommercial models, absent and disabled by
default, available only after an explicit in-app request and licence confirmation.
Their restrictions remain in effect. Thanks to all model authors and to Upscayl
for inspiration and selected aspects of early model research; full attribution
and original licence texts accompany the packages.
