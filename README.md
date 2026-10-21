# UpScape

AI image enlargement for scanning-electron-microscope images and photographs of objects, as
one native desktop program. Pick a model, set the final factor, judge Original, classical
filter, AI result and blend side by side, and save a result whose provenance is recorded.

**Status: 0.90.32 beta.** Linux x86-64 and Windows x64 builds are on the
[Releases](https://github.com/WaveboSF/UpScape/releases) page; [INSTALL.md](INSTALL.md) explains the three archives and the
first start. This Rust version replaces an earlier Python/PySide6 program that remains the
frozen reference its behaviour was verified against.

![UpScape 0.90.32 beta: a synthetic 16-bit test image enlarged 4x, shown as Original,
classical filter, AI result and blend](docs/screenshot.png)

## What it does

- **Four views that move together.** Original, the selected classical filter, the AI result
  and the blend of the two, in a 2x2 grid with one shared zoom and position; a draggable
  divider view and a variants grid (several models at several blend weights, computed on the
  visible excerpt) for the decision.
- **A blend you can declare.** The saved pixels are `w * ai + (1 - w) * classical`, mixed in
  float before quantisation; `w` is written into the provenance and, on request, stamped
  into the image together with the factor.
- **Region of interest.** Draw a yellow rectangle in any view, confirm it, and let the model
  see only that region (the rest is enlarged classically, so a burned-in scale bar stays
  legible) or crop to it and work on the crop; undo restores the previous image.
- **Microscopy data stays intact.** 16-bit greyscale TIFF in, 16-bit greyscale TIFF out;
  greyscale never becomes colour; a pixel size in the metadata is rescaled, not copied;
  16-bit input always computes in Float32.
- **Nine models, licence visible.** Real-ESRGAN's general, conservative, fast, 2x and
  drawing models, 4x-HFA2k, and two NonCommercial models marked as such; a model's licence
  goes into every result's provenance. Weights are fetched from the publishers and verified
  by SHA-256; nothing is bundled that may not be.
- **Folders.** Set up the first image, approve it, and run the rest of a folder with the
  same settings; stop at once or after the current image.
- **Four setups** (S1-S4) for recurring configurations, saved in the same JSON files the
  Python version uses; image adjustments (brightness, contrast, saturation, black level)
  applied to what is shown and saved; light and dark theme; a guide with an index search.

## Download and install

| Archive | For |
|---|---|
| `UpScape-0.90.32-beta-linux-x86_64.tar.gz` | Linux x86-64 (glibc 2.43 or newer); CPU, and NVIDIA GPUs through ONNX Runtime's CUDA provider when CUDA 13 and cuDNN 9 are present |
| `UpScape-0.90.32-beta-windows-x86_64.zip` | Windows 10/11 x64; CPU |
| `UpScape-0.90.32-beta-models-onnx.zip` | the prepared ONNX graphs of the seven redistributable models; unpack it inside the program folder (both platforms) |

Unpack, start (`UpScape.sh` on Linux, `UpScape.exe` on Windows), then **Settings > Setup... >
Download missing** once. Details, GPU setup, where settings live and what to do when
something does not start: [INSTALL.md](INSTALL.md).

## Privacy

UpScape sends nothing anywhere. The only network access is the model download you start in
Setup, to the publishers' addresses listed in `data/models.toml`. ONNX Runtime ships
Microsoft's telemetry client; the programs switch it off before the runtime loads.

## Known limitations of the beta

- The Windows build was cross-compiled on Linux and tested under Wine, not yet on Windows;
  it computes on the CPU only, and it is not code-signed (SmartScreen will ask once).
- The Linux build needs glibc 2.43 (Ubuntu 26.04 or newer).
- The two NonCommercial models have no distributed prepared graph in this beta.
- On Wayland desktops files cannot be dropped on the window yet (use File > Open).
- Dialogs are drawn inside the window; number fields have no spin arrows; the full-text
  browser of library licences of the Python version is not built yet (the texts are in
  `LICENSES/`).

## Source

This repository carries the releases and their documentation. The source code of UpScape
(Rust) and of its Python reference program is kept in the author's own repositories; the
list of Rust libraries the program is built from, with their licences, is in
`LICENSES/rust-libraries.json`.

## Credits and licence

UpScape's own code is MIT, Copyright (c) 2026 Silvestar Friedrich ([LICENSE](LICENSE)). It
builds on [ONNX Runtime](https://onnxruntime.ai) (MIT), [egui](https://github.com/emilk/egui)
(MIT/Apache-2.0) and the Rust crates listed in `LICENSES/rust-libraries.json`. The
models are the work of their authors: [Real-ESRGAN](https://github.com/xinntao/Real-ESRGAN) by
Xintao Wang et al. (BSD-3-Clause), [4x-HFA2k](https://openmodeldb.info/models/4x-HFA2k) by
Philip Hofmann (CC-BY-4.0), and the NonCommercial 4x-Remacri and 4x-UltraSharp
(CC-BY-NC-SA-4.0). UpScape uses the published weights as they are; nothing was fine-tuned on
microscope data.
