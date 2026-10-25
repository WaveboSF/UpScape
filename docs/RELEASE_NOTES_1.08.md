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

## Downloads

- `UpScape-1.08-windows-x64-setup.exe`: native x64 Windows installer, CPU/DirectML.
- `UpScape-1.08-linux-x86_64.tar.gz`: Linux x86-64, CPU/optional NVIDIA CUDA.
- Each package has a matching `.sha256` file. Both store internal build 1.08.03.

The public repository contains downloads, documentation and notices; the
application source remains private. No separate model pack or Python is needed.
See [installation requirements](https://github.com/WaveboSF/UpScape/blob/main/INSTALL.md).

## Validation and limitations

Linux package and installed payload inventories match. Real offline CPU/DNI first
use and isolated native GUI/ROI checks passed. A bounded installed-package test
ran nine CPU references and eighteen CUDA jobs on RTX 5090 and RTX 4090. All
sixteen Float32 comparisons passed the existing tolerance, maximum one 16-bit
level; routing used the selected GPU with TF32 disabled and no CPU fallback.

Two Fast/automatic Float16 runs completed with differences up to two 8-bit levels
and cuDNN frontend plan diagnostics. They are observations, without an established
Float16 numerical acceptance bound. Use Float32 when close CPU agreement matters.
These checks do not establish performance or every-image/driver compatibility.

The Windows 1.08.03 installer was built natively and its full package independently
audited; fresh offline CPU/DNI checks passed. DirectML fixes are included, but a
new 1.08 DirectML image-comparison campaign and detailed interactive installer/UI
acceptance remain open. Select CPU if GPU output is unexpected and retain the log.

Linux needs glibc 2.43+; optional GPU execution needs NVIDIA CUDA 13 and cuDNN 9.
Windows uses DirectML with a compatible DirectX 12 adapter; its installer is
unsigned. Linux AMD/Intel GPU compute, Windows CUDA and macOS builds are not
included. On Wayland, use Open image rather than drag-and-drop.

Remacri/UltraSharp remain optional NonCommercial models, absent and disabled by
default, available only after an explicit in-app request and licence confirmation.
Their restrictions remain in effect. Thanks to all model authors and to Upscayl
for inspiration and selected aspects of early model research; full attribution
and original licence texts accompany the packages.
