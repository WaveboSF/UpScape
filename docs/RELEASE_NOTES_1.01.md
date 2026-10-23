# UpScape v1.01

Native Rust desktop application for AI enlargement of microscope and object images.

> **Windows GPU / DirectML issue (v1.01):** GPU processing through DirectML still has
> known problems. For now, select **CPU** in **Settings > Setup... > Device**.
> A fix is planned for **v1.02**.

## Downloads

- **Windows 10/11 x64:** `UpScape-1.01-windows-x64-setup.exe` (505 MB).
- **Linux x86-64:** `UpScape-1.01-linux-x86_64.tar.gz` (676 MB; glibc 2.43 or newer).
- Each program file has a matching `.sha256` checksum file.

Download the file for your operating system. Each package includes the runtime libraries,
redistributable prepared AI models and licence notices. No separate model archive or
Python installation is required. GitHub's automatic **Source code** archives contain
documentation, not the application.

## Getting started

On Windows, run the installer and start UpScape from the Start menu or desktop shortcut.
The installer includes the Microsoft Visual C++ runtime. It is not code-signed, so
SmartScreen may display a warning.

On Linux, unpack the archive, enter `UpScape-1.01-linux-x86_64` and run `./UpScape.sh`.
Optionally run `./install-desktop-icon.sh` for a desktop shortcut and menu entry.

Open **Settings > Setup... > Download missing** if weights are missing. Model weights
come from their publishers and are verified by SHA-256. The optional NonCommercial
Remacri and UltraSharp models are prepared locally after their weights are downloaded;
they retain their CC BY-NC-SA 4.0 licence.

GPU support: DirectML on Windows; NVIDIA CUDA 13 with cuDNN 9 on Linux. CPU processing is
available on both platforms. Windows GPU use has been tried on NVIDIA hardware; AMD and
Intel cards have not been tested with UpScape. Linux Wayland users should use **File > Open**
instead of drag and drop.

Installation, checksum commands and troubleshooting:
[INSTALL.md](https://github.com/WaveboSF/UpScape/blob/main/INSTALL.md).
