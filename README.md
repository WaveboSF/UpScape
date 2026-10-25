# UpScape

**A desktop image upscaler for Windows and Linux.** Enlarge photos and other
images with AI or classical filters, blend their results, and compare alternatives
before saving. Microscopy and object images are among its uses.

**[Download UpScape 1.08](https://github.com/WaveboSF/UpScape/releases/tag/v1.08)**

| Platform | Download | Checksum |
|---|---|---|
| Windows 10/11, x64 | [Installer](https://github.com/WaveboSF/UpScape/releases/download/v1.08/UpScape-1.08-windows-x64-setup.exe) | [SHA-256](https://github.com/WaveboSF/UpScape/releases/download/v1.08/UpScape-1.08-windows-x64-setup.exe.sha256) |
| Linux, x86-64, glibc 2.43+ | [Archive](https://github.com/WaveboSF/UpScape/releases/download/v1.08/UpScape-1.08-linux-x86_64.tar.gz) | [SHA-256](https://github.com/WaveboSF/UpScape/releases/download/v1.08/UpScape-1.08-linux-x86_64.tar.gz.sha256) |

Each download includes the program, its inference runtime, seven redistributable
original weight files and six prepared model bundles. The baseline works offline;
no separate model pack or Python installation is required.
Read [installation and requirements](INSTALL.md) before downloading.

## Blend and Variants

**Blend** lets you mix the AI result with the original or a classical filter,
controlling how much of the processed image you keep. Compare the views and
adjust the share before saving.

**Variants** helps you compare model and blend choices for the same image.
It can require substantial processing time and memory. Without a usable GPU,
at least eight verified physical CPU cores are required and a warning is shown.

## What changed since 1.01

- Complete offline baseline and expanded library licence texts and model credits.
- Improved GPU handling, DirectML fixes, CPU thread limits that leave capacity
  for the OS/UI, and hardware prerequisites under **Info > System info**.
- Eight saved setups, S1-S8, and a clearer Batch workbench with thumbnails,
  selected files and reusable processing settings.
- Easier ROI selection, cropping and transparent cutouts; more flexible Save
  formats and filename templates.
- A larger watermark editor with installed fonts, size/position/rotation controls,
  color palettes and direct manipulation; improved window-state handling.

See the [1.08 release notes](docs/RELEASE_NOTES_1.08.md) for download details.

## Platform support

| Platform | CPU processing | Optional GPU processing |
|---|---|---|
| Windows x64 | Included | DirectML with a compatible DirectX 12 adapter and driver; NVIDIA, AMD or Intel |
| Linux x86-64 | Included | NVIDIA CUDA 13 with cuDNN 9; these optional system libraries are required for CUDA |

Linux AMD/Intel GPU execution and Windows CUDA are not provided by these builds.
On Wayland, use **Open image**; drag-and-drop remains limited.

## Contributors

UpScape is developed and maintained by [S.F. / WaveboSF](https://github.com/WaveboSF).
Development has been assisted by **Anthropic Claude** and **[OpenAI Codex](https://github.com/codex)**.
We acknowledge both AI tools for their contributions to implementation,
troubleshooting, testing and documentation. Project decisions and release
responsibility remain with the maintainer.

## Models, licences and acknowledgements

The baseline includes Real-ESRGAN/Real-ESRNet models by Xintao Wang and
contributors (BSD-3-Clause), and HFA2k by helaman / Philip Hofmann (CC-BY-4.0).
**Remacri and UltraSharp are optional NonCommercial models** (CC-BY-NC-SA-4.0).
Their weights and graphs are absent from both downloads and disabled by default.
An explicit in-app request and licence confirmation are required; downloading
does not remove their NonCommercial restrictions.

[Upscayl](https://github.com/upscayl/upscayl) was one of UpScape's inspirations.
Selected aspects of its model catalogue and packaged-weight handling informed
early research. Warm thanks to its team and contributors, and to all model
authors. The [full acknowledgements](LICENSES/ACKNOWLEDGEMENTS.md) identify every
catalogue model, its author, source and licence. Original licence texts and
copyright notices accompany the binary packages.

This repository distributes binary packages, user documentation and notices.
Application source code is maintained privately. GitHub's automatically generated
source archives contain this public documentation repository, not the UpScape
application source. UpScape's own licence is [MIT](LICENSE); third-party
software and models retain their respective licences.
