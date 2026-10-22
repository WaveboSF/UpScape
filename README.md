# UpScape

AI image enlargement for scanning-electron-microscope images and photographs of objects.
UpScape is a native Rust desktop application for Windows and Linux.

**Current release: [UpScape v1.01](https://github.com/WaveboSF/UpScape/releases/tag/v1.01).**

## Download

| System | Download | Size |
|---|---|---|
| Windows 10/11, 64-bit | [Windows installer](https://github.com/WaveboSF/UpScape/releases/download/v1.01/UpScape-1.01-windows-x64-setup.exe) | 505 MB |
| Linux x86-64, glibc 2.43 or newer | [Linux archive](https://github.com/WaveboSF/UpScape/releases/download/v1.01/UpScape-1.01-linux-x86_64.tar.gz) | 676 MB |

Each download includes the program, its runtime libraries, the redistributable prepared
AI models and their licence notices. Download the file for your system; no separate models
archive or Python installation is needed.

SHA-256 checksums are attached to the [release](https://github.com/WaveboSF/UpScape/releases/tag/v1.01).
The automatically generated **Source code** archives contain this repository's documentation,
not the desktop application.

## First start

**Windows:** run the installer, then start UpScape from the Start menu or desktop shortcut.
The installer is not code-signed, so Windows SmartScreen may display a warning. It includes
the Microsoft Visual C++ runtime and can download the model weights during installation.

**Linux:** unpack the archive and start the launcher:

```bash
tar -xzf UpScape-1.01-linux-x86_64.tar.gz
cd UpScape-1.01-linux-x86_64
./UpScape.sh
```

Keep the unpacked folder together. Optionally run `./install-desktop-icon.sh` to create
a desktop shortcut and applications-menu entry.

In **Settings > Setup...**, choose a device and use **Download missing** if model weights
are missing. Downloads go to the models' publishers and are checked by SHA-256. Then open
an image, choose a model and enlargement factor, click **Upscale**, compare and save.

Full installation, GPU setup, checksum verification and troubleshooting: [INSTALL.md](INSTALL.md).

## Features

- Compare the original, a classical filter, the AI result and their blend with shared zoom
  and position; use a divider or a variants grid to judge the result.
- Choose the final enlargement factor and blend weight, or process a selected region.
- Preserve 16-bit greyscale TIFF data and record the result's processing provenance.
- Process a folder with shared settings and save recurring configurations in four setups.
- Use a GPU when available: DirectML on Windows, CUDA 13 and cuDNN 9 on Linux with NVIDIA;
  CPU processing is available on both systems.

## Inspiration and thanks

[Upscayl](https://github.com/upscayl/upscayl) was the original spark for UpScape.

A heartfelt thank you to the Upscayl team and all contributors for this wonderful project,
for sharing your work with the community, and for inspiring us to develop UpScape.

## Models and licences

The package includes prepared models from Real-ESRGAN and 4x-HFA2k. Original model weights
are downloaded from their publishers when needed. Each model's licence is shown in Setup.

The optional Remacri and UltraSharp models are **NonCommercial (CC BY-NC-SA 4.0)**.
Their weights and prepared graphs are not bundled. After the licence confirmation,
**Download missing** downloads their weights and prepares their graphs on your computer.

UpScape's own code is MIT, Copyright (c) 2026 Silvestar Friedrich ([LICENSE](LICENSE)).
Third-party software and models retain their own licences; notices are included in each
download and in [LICENSES](LICENSES).

## Compatibility

Linux requires glibc 2.43 or newer, for example Ubuntu 26.04. On Wayland, use **File > Open**
to select images because dropping files onto the window is not supported yet.

Windows GPU processing has been tried on NVIDIA hardware. AMD and Intel DirectX 12 cards
are supported through DirectML but have not been tested with UpScape. If GPU processing
fails, select **CPU** in Setup and consult [INSTALL.md](INSTALL.md).

This repository distributes UpScape releases and user documentation. The application
source code is maintained separately and is not included here.
