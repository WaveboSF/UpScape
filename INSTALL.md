# Installing UpScape 0.90.32 beta

UpScape is a desktop program for AI image enlargement, written for scanning-electron-
microscope images and colour photographs of objects. This is the native Rust build: one
program, no Python at run time. It is a **beta**: the behaviour was verified against the
Python reference on Linux; the Windows build was cross-compiled on Linux and checked
under Wine, not yet on a real Windows machine.

## What to download

Three archives belong to one release. The models archive is shared by both platforms.

| Archive | Platform | Contents |
|---|---|---|
| `UpScape-0.90.32-beta-linux-x86_64.tar.gz` | Linux, 64-bit x86 | program, ONNX Runtime 1.31.0 (CPU and CUDA provider), data, licences |
| `UpScape-0.90.32-beta-windows-x86_64.zip` | Windows 10/11, 64-bit x86 | `UpScape.exe`, `upscape.exe`, ONNX Runtime 1.31.0 (CPU), data, licences |
| `UpScape-0.90.32-beta-models-onnx.zip` | both | the prepared ONNX graphs of the seven models that may be redistributed |

Every archive has a `.sha256` file next to it. Check a download before unpacking:

```bash
sha256sum -c UpScape-0.90.32-beta-linux-x86_64.tar.gz.sha256
```

On Windows: `certutil -hashfile UpScape-0.90.32-beta-windows-x86_64.zip SHA256` and compare
with the content of the `.sha256` file.

## Requirements

- **CPU:** any 64-bit x86 processor. Enlarging a 2048 px image 4x with a 4x model takes a
  few minutes on the CPU and about 3 GB of free memory; larger inputs need more.
- **Linux:** a 64-bit distribution with glibc 2.43 or newer - the beta was built on Ubuntu
  26.04, and older distributions cannot start it yet. Nothing is installed system-wide; the
  folder is self-contained.
- **Windows:** Windows 10 or 11, 64-bit. No installer, no registry entries, no services.
- **GPU (Linux only, optional):** an NVIDIA card with the CUDA 13 and cuDNN 9 libraries
  present on the machine. Without them UpScape computes on the CPU; a GPU chosen in Setup
  never falls back to the CPU silently, it reports the missing library instead.
- **Internet:** once per model, to fetch the model weights from their publishers
  (Settings > Setup... > Download missing). Nothing else connects anywhere.

## Linux

1. Unpack the program and, inside that folder, the models archive:

   ```bash
   tar -xzf UpScape-0.90.32-beta-linux-x86_64.tar.gz
   cd UpScape-0.90.32-beta-linux-x86_64
   unzip ../UpScape-0.90.32-beta-models-onnx.zip
   ```

   The second step creates `onnx/` next to `UpScape.sh`. Keep the folder together; the
   program finds its data, runtime and models relative to itself.

2. Start it:

   ```bash
   ./UpScape.sh
   ```

   `UpScape.sh` sets the library path and the data folder and starts `upscape`. A file
   manager that asks whether to run or display the script: run it. For a desktop launcher
   point `Exec` at the script's full path.

3. First start: open **Settings > Setup...** and click **Download missing**. The weights
   (about 67 MB for most models, 5 MB for Fast 4x) are fetched from the publishers' own
   addresses listed in `data/models.toml`, verified by SHA-256 and stored in
   `~/.local/share/upscape/models`. Choose the device under **Device**: the CPU, or a GPU
   when its libraries are present.

4. Open an image (File > Open, or drop it on the window - see the Wayland note below),
   pick a model, set the final factor, click **Upscale**, judge the four views, save.

Settings live in `~/.config/upscape` (`settings.json`, `setups.json`, `ui_state.json`).
To remove UpScape, delete the unpacked folder and, if wanted, those two folders.

**GPU on Linux.** `UpScape.sh` adds `/usr/local/cuda/lib64`, a `cuda-libs/` folder next to
the script, and the folders named in the environment variable `UPSCAPE_CUDA_LIBS`
(colon-separated) to the library path when they exist. cuDNN 9 is often installed with a
Python package (`nvidia/cudnn/lib` inside a `site-packages` folder); name that folder in
`UPSCAPE_CUDA_LIBS` or copy its libraries into `cuda-libs/`. Then choose the card in
Settings > Setup... > Device; the choice is stored by the card's UUID, so it stays the same
card after a reboot.

**Wayland.** Dropping a file on the window does not work on Wayland desktops yet (the
toolkit does not receive drops there); the empty Original view says so. Use File > Open or
start the program with the image as argument. Under X11 drops work.

## Windows

1. Unpack `UpScape-0.90.32-beta-windows-x86_64.zip` (right-click > Extract all...).
2. Unpack `UpScape-0.90.32-beta-models-onnx.zip` **into that folder**, so that `onnx\`
   ends up next to `UpScape.exe`.
3. Double-click `UpScape.exe`. The program is not code-signed yet: SmartScreen may show
   "Windows protected your PC" - choose *More info* and *Run anyway*. `upscape.exe` is the
   same program with a console, for the command line (`upscape.exe --help`).
4. First start: **Settings > Setup... > Download missing**, as on Linux. Weights are stored in
   `%LOCALAPPDATA%\upscape\models`, settings in `%APPDATA%\upscape`.
5. Open an image, pick a model, set the factor, **Upscale**, judge, save.

This Windows build computes on the CPU; a Windows GPU build is not part of the beta. To
remove UpScape, delete the folder and, if wanted, the two folders above.

## The models

The catalogue holds nine models. Seven may be redistributed and are in the models archive,
each as a prepared ONNX graph in two precisions plus a manifest with the SHA-256 of every
file; their original weights are still fetched and verified at first use, so provenance
stays with the publisher's file:

| In the window | Id | Licence |
|---|---|---|
| General 4x | `realesrgan-x4plus` | BSD-3-Clause (Xintao Wang et al.) |
| Conservative 4x | `realesrnet-x4plus` | BSD-3-Clause |
| General 2x | `realesrgan-x2plus` | BSD-3-Clause |
| Fast 4x (with its denoise partner) | `realesr-general-x4v3`, `realesr-general-wdn-x4v3` | BSD-3-Clause |
| Drawing 4x | `realesrgan-x4plus-anime-6b` | BSD-3-Clause |
| High fidelity 4x | `4x-hfa2k` | CC-BY-4.0 (Philip Hofmann) |

Two models, Remacri 4x and UltraSharp 4x, are CC-BY-NC-SA-4.0 (NonCommercial). They are
listed in Setup with that mark, but their prepared graphs are **not** distributed with this
beta, and this build cannot prepare graphs itself. Starting one of them reports that its
prepared model is missing. Switch them off in Setup if the mark is in the way.

A result's provenance file (`.json` next to the saved image) names the model, its licence,
the factor, the blend weight and the device, so a result's origin can be checked later.

## Troubleshooting

- *"ONNX Runtime library is missing"* - on Linux start through `UpScape.sh`, not `upscape`
  directly; on Windows keep the `.dll` files next to `UpScape.exe`.
- *"prepared ONNX model ... not found"* - the models archive was not unpacked next to the
  program (`onnx/` beside `UpScape.sh` or `UpScape.exe`), or the model is one of the two
  NonCommercial ones.
- *A GPU is chosen and the job fails naming a CUDA or cuDNN library* - the library folders
  are not on the path (see GPU on Linux above); choose the CPU meanwhile.
- *The window is tiny or huge* - the window follows the desktop's scale factor; Settings
  offers fixed sizes (Ctrl+1 to Ctrl+4) and fullscreen (Ctrl+F).
- *Nothing happens when a file is dropped* - Wayland, see above.

## Privacy

UpScape sends nothing anywhere. The only network access is the model download you start in
Setup, to the publishers' addresses. ONNX Runtime contains Microsoft's telemetry client; the
programs switch it off before the runtime is loaded (`ORT_DISABLE_TELEMETRY=1`), and no
telemetry store is created.

## Licences

UpScape's own code is MIT (`LICENSE`). The folder `LICENSES/` carries ONNX Runtime's licence
and third-party notices, the list of Rust libraries with their licences
(`rust-libraries.json`) and the data licences. Model weights keep the licences in the table
above; the models archive carries their notices.
