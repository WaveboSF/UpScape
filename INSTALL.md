# Installing UpScape 1.01

UpScape is a desktop program for AI image enlargement, written for scanning-electron-
microscope images and colour photographs of objects. This is the native Rust build: one
program, no Python at run time. What has been checked, and what has not: the behaviour was
verified against the Python reference on Linux; the Windows build is cross-compiled on Linux and
was checked under Wine, and its owner ran the installer on a real Windows machine (the program
starts, the two NonCommercial models work, the graphics card is used through DirectML). It has not
yet been tried on other machines or by other people, and the installer is not code-signed
(SmartScreen will ask once).

## What to download

A release is **one file per operating system**. Everything the program needs is inside it, the prepared AI models included.

| File | Platform | Contents |
|---|---|---|
| `UpScape-1.01-linux-x86_64.tar.gz` | Linux, 64-bit x86 | program, ONNX Runtime 1.31.0 (CPU and CUDA provider), data, licences and the prepared ONNX models of the seven models that may be redistributed (`onnx/`), about 680 MB |
| `UpScape-1.01-windows-x64-setup.exe` | Windows 10/11, 64-bit x86 | **the installer:** `UpScape.exe`, `upscape-cli.exe`, ONNX Runtime 1.24.4 with the DirectML provider (CPU and GPU), Microsoft's DirectML library, data, licences, the prepared ONNX models and the Microsoft Visual C++ runtime installer, about 500 MB |

Each file has a `.sha256` file next to it. Check a download before you use it:

```bash
sha256sum -c UpScape-1.01-linux-x86_64.tar.gz.sha256
```

On Windows: `certutil -hashfile UpScape-1.01-windows-x64-setup.exe SHA256` and compare
with the content of the `.sha256` file.

## Requirements

- **CPU:** any 64-bit x86 processor. Enlarging a 2048 px image 4x with a 4x model takes a
  few minutes on the CPU and about 3 GB of free memory; larger inputs need more.
- **Linux:** a 64-bit distribution with glibc 2.43 or newer - the program is built on Ubuntu
  26.04, and older distributions cannot start it yet. Nothing is installed system-wide; the
  folder is self-contained.
- **Windows:** Windows 10 or 11, 64-bit. The installer needs no other software: it brings the
  Microsoft Visual C++ runtime that ONNX Runtime needs and installs it only if the machine has
  none or an older one. No services, no autostart, no `PATH` change.
- **GPU, Windows (optional, nothing to install):** any DirectX 12 graphics card (NVIDIA, AMD,
  Intel) through DirectML, which the installer brings. **Automatic** in Setup > Device takes the
  card with the most video memory, and the CPU when there is none or the card cannot be used (the
  log says why). Windows 10 version 1903 or newer.
- **GPU, Linux (optional):** an NVIDIA card with the CUDA 13 and cuDNN 9 libraries present on
  the machine. **Automatic** takes the card with the most memory when cuDNN can be found (the
  folders named in `UPSCAPE_CUDA_LIBS`, `cuda-libs/` beside the program, the CUDA toolkit
  folders) and the CPU otherwise, with a note in the log; a GPU chosen explicitly in Setup never
  falls back to the CPU silently, it reports the missing library instead.
- **Internet:** once per model, to fetch the model weights from their publishers
  (Settings > Setup... > Download missing). Nothing else connects anywhere.

## Linux

1. Unpack the program:

   ```bash
   tar -xzf UpScape-1.01-linux-x86_64.tar.gz
   cd UpScape-1.01-linux-x86_64
   ```

   The prepared models are in `onnx/` next to `UpScape.sh`. Keep the folder together; the
   program finds its data, runtime and models relative to itself.

2. Start it:

   ```bash
   ./UpScape.sh
   ```

   `UpScape.sh` sets the library path and the data folder and starts `upscape`. A file
   manager that asks whether to run or display the script: run it. For a desktop launcher
   point `Exec` at the script's full path.

3. Optional, once: a desktop icon and an applications-menu entry with the UpScape logo for this folder,
   and, on a machine with an NVIDIA card, the link that lets the program find cuDNN 9:

   ```bash
   ./install-desktop-icon.sh
   ```

   It writes `UpScape.desktop` on the desktop and into `~/.local/share/applications`, both pointing at this
   folder's `UpScape.sh`; run it again after moving the folder. A launcher of the same name that points
   elsewhere is left alone (`--replace` keeps it as `.bak`); `./uninstall-desktop-icon.sh` removes exactly what
   the script wrote.

   **GPU step.** If cuDNN 9 is already available to the program (the system's library cache or the CUDA toolkit
   folders) nothing is done. Otherwise the script looks for the NVIDIA pip package of cuDNN 9 for CUDA 13 (the
   `nvidia/cudnn/lib` folder of a Python environment, in your home folder or found by the file index), and links it
   as `cuda-libs` next to `UpScape.sh`. It links only a cuDNN of the right CUDA generation that nobody else can
   write; a folder you name yourself is taken as it is. If none is found it says so and UpScape computes on the CPU.
   To name the folder yourself: `./install-desktop-icon.sh --cudnn-dir /path/to/nvidia/cudnn/lib`
   (the folder that holds `libcudnn.so.9`); `--no-gpu-setup` skips the step. The uninstall script removes this
   link too, and only a link the install script made.

4. First start: open **Settings > Setup...** and click **Download missing**. The weights
   (about 67 MB for most models, 5 MB for Fast 4x) are fetched from the publishers' own
   addresses listed in `data/models.toml`, verified by SHA-256 and stored in
   `~/.local/share/upscape/models`. Choose the device under **Device**: the CPU, or a GPU
   when its libraries are present.

5. Open an image (File > Open, or drop it on the window - see the Wayland note below),
   pick a model, set the final factor, click **Upscale**, judge the four views, save.

Settings live in `~/.config/upscape` (`settings.json`, `setups.json`, `ui_state.json`).
To remove UpScape, delete the unpacked folder and, if wanted, those two folders.

**GPU on Linux.** `UpScape.sh` adds `/usr/local/cuda/lib64`, a `cuda-libs/` folder next to
the script, and the folders named in the environment variable `UPSCAPE_CUDA_LIBS`
(colon-separated) to the library path when they exist. cuDNN 9 is often installed with a
Python package (`nvidia/cudnn/lib` inside a `site-packages` folder); `install-desktop-icon.sh`
finds such a package and links it as `cuda-libs/` (step 3 above). By hand: name that folder in
`UPSCAPE_CUDA_LIBS` or copy its libraries into `cuda-libs/`. Then choose the card in
Settings > Setup... > Device; the choice is stored by the card's UUID, so it stays the same
card after a reboot.

**Wayland.** Dropping a file on the window does not work on Wayland desktops yet (the
toolkit does not receive drops there); the empty Original view says so. Use File > Open or
start the program with the image as argument. Under X11 drops work.

## Windows

### With the installer (recommended)

1. Check the download (`certutil -hashfile <file> SHA256`, compare with the `.sha256` file) and
   double-click `UpScape-1.01-windows-x64-setup.exe`. The installer is not code-signed
   yet: SmartScreen may show "Windows protected your PC" - choose *More info* and *Run anyway*.
2. **Install for** *anyone who uses this computer* (Program Files) or *only me*
   (`%LOCALAPPDATA%\Programs\UpScape`, no administrator needed). The choice is offered only when the
   installer runs with administrator rights (right-click the file > *Run as administrator*, or start it from
   an administrator account); a standard user gets the *only me* install directly.
3. **Components:** the program (always), the prepared AI models, a desktop shortcut,
   **Download the AI model weights now** (about 300 MB from the publishers' own addresses, each file
   verified by SHA-256; needs internet once) and, **off unless you tick it**, **Also download and
   prepare the two NonCommercial models** (CC BY-NC-SA 4.0, not for commercial use; about 134 MB of weights and about 134 MB of graphs built from them;
   it needs the prepared AI models). Untick the weight download to do it later under
   Settings > Setup... > Download missing. The weights land in `%LOCALAPPDATA%\upscape\models` of the
   account that runs the installer, and the graphs built for the NonCommercial models in
   `%LOCALAPPDATA%\upscape\onnx`. A silent install takes `/NONCOMMERCIAL` for the last component and
   `/NOWEIGHTS` to skip every download.
4. The installer then checks the Microsoft Visual C++ runtime. If it is missing or older than
   14.44.35211 it runs the Microsoft installer it carries, **after** Windows has confirmed that file's
   Microsoft signature; a standard user sees Windows' own administrator prompt for just this step. If
   that fails, the installer says so and where to get the runtime (https://aka.ms/vs/17/release/vc_redist.x64.exe).
5. Finish: start UpScape. A Start-menu folder (program, uninstaller) and an entry in *Apps &
   features* were created; settings live in `%APPDATA%\upscape`.

The install folder must be new, empty, or one an earlier UpScape install registered; a folder that holds
other files is refused, so that installing never overwrites anything that is not UpScape's. **Uninstall**
from *Apps & features* or the Start menu: it deletes exactly the files the installer wrote and the folders
that are then empty, so files you added yourself (for example a graph you put into `onnx\`) stay.
It asks before deleting your settings, the downloaded weights and the graphs built from them
(`%LOCALAPPDATA%\upscape`). Two installs side by side (all users and
current user, or two folders) are removed one by one; the shortcuts and Apps & features entry belong to
the one installed last.

**Unattended:** `UpScape-...-setup.exe /S /allusers` (or `/currentuser`), optionally `/D=C:\Tools\UpScape`
(**unquoted**, an absolute path, the last argument - a quoted or misplaced `/D=` is refused with exit code 3
when the installer is started directly, but `cmd.exe` can hand it over in a form the installer does not recognise,
and then it installs into the default folder without a message: check the folder afterwards, or put the path in
the wizard), `/NOWEIGHTS` (no weight download), `/SKIPVCREDIST` (the runtime is managed
elsewhere). Exit code 0 = installed; 2 = the folder holds other files; 3 = bad `/D=`; 11 = installed but
the Visual C++ runtime is still missing. `/allusers` needs an administrator; without administrator rights
Windows shows an error box even in silent mode (an unattended deployment should use `/currentuser` or run
elevated). Uninstall: `"<folder>\uninstall.exe" /AllUsers /S` or `/CurrentUser /S` (the same mode as the
install; the *Apps & features* entry and the Start-menu shortcut already pass it).

After the installation: double-click **UpScape** (desktop or Start menu). `upscape-cli.exe` in the
install folder is the same program with a console, for the command line (`upscape-cli.exe --help`); it
finds `data\`, `onnxruntime.dll` and `onnx\` in its own folder. On the first start open
**Settings > Setup... > Download missing**, as on Linux (skip it if the installer already fetched the
weights), then open an image, pick a model, set the factor, **Upscale**, judge, save.

The Windows build computes on the graphics card through DirectML when Setup > Device is *Automatic* and the machine has one, else on the CPU; *CPU* forces the CPU. It runs the Float32 graph (no half precision); how closely it matches the CPU result is not measured yet. The DirectML route is new: the developer ran it on a real Windows machine with a graphics card and it works when the card has enough video memory; a card with too little shows an out-of-memory error (the program first retries with smaller tiles). If a job fails there, choose *CPU* in Setup > Device and report the message.

## The models

The catalogue holds nine models. Seven may be redistributed and are in the package (the `onnx/`
folder), each as a prepared ONNX graph in two precisions plus a manifest with the SHA-256 of every
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

Two models, Remacri 4x and UltraSharp 4x, are CC-BY-NC-SA-4.0 (NonCommercial: not for
commercial use). They are listed in Setup with that mark. Neither their weights nor a
graph made from them are distributed with UpScape - not in the Linux file, not in the
installer. **Settings > Setup... > Download missing** fetches their weights from the
publishers (after asking about the licence) and then **builds the prepared graph on your
own computer** from them: the program verifies the downloaded file by SHA-256, reads its
weights and writes them into a copy of the graph of Real-ESRGAN General 4x, which is the
same network (RRDBNet, 23 blocks; in general the graph of the first redistributable model with the same
architecture and scale) - the result is `<data>/onnx/<id>-fp32.onnx` plus its
manifest, where `<data>` is `~/.local/share/upscape` on Linux and `%LOCALAPPDATA%\upscape`
on Windows. Nothing is sent anywhere; if you moved the weights with `UPSCAPE_MODELS_DIR`, only the weights moved - the graphs built from them stay in the folder named above (about 134 MB each); the step takes a few seconds and needs the `onnx/`
folder of the package for the General 4x graph. Setup's ONNX column shows
"not prepared" until then and "ready" afterwards. These two graphs are Float32 only: a
GPU job with fp16 selected computes in Float32 for them and says so in the log. The same
is available on the command line:

```
upscape manage --data-dir DIR <<< '{"op":"models_download","model_id":"4x-remacri"}'
upscape manage --data-dir DIR <<< '{"op":"models_prepare","model_id":"4x-remacri"}'
```

(`models_download` prepares the graph itself for these models and reports `prepared` or
`prepare_error`; `models_prepare` runs just that step, for example after the weights were
fetched earlier.) Removing the model in Setup deletes the weights and the graph made from
them. A graph built here is an adaptation of those weights and stays under CC BY-NC-SA 4.0 (not for
commercial use, attribution, share-alike): do not pass it on or put it into something you hand to others. Switch the two models off in Setup if the mark is in the way.

A saved result carries its origin inside the file: TIFF, PNG and JPEG hold a summary (the model and
its licence, the factor, the blend weight, the precision) in their own metadata, so a result's origin
can be checked later. The window writes no `.json` file beside the image. Only a NonCommercial
model's result in a format without such metadata (WebP, BMP) still gets a provenance file (`.json`
next to the image), and the command line writes one unless `--no-sidecar` is given.

## Troubleshooting

- *"ONNX Runtime library is missing"* - on Linux start through `UpScape.sh`, not `upscape`
  directly; on Windows keep the `.dll` files next to `UpScape.exe`.
- *"prepared ONNX model ... not found"* / *"the prepared graph of ... is not installed"* - the
  `onnx/` folder is missing next to `UpScape.sh` or `UpScape.exe` (it was moved or deleted, or the
  installer's models component was unticked): unpack the Linux file again, or run the installer again.
- *"... has no prepared graph yet"* - one of the two NonCommercial models: its graph is built
  on your computer from the downloaded weights; run **Settings > Setup... > Download
  missing** (or `models_prepare`, above).
- *"no architecture graph fits ..."* / *"the prepared graph of realesrgan-x4plus is not
  installed"* while preparing - the General 4x graph from the package's `onnx/` folder is the
  template and it is missing or damaged; unpack the Linux file or run the installer again.
- *A GPU is chosen and the job fails naming a CUDA or cuDNN library* - the program looks for
  cuDNN 9 itself (`UPSCAPE_CUDA_LIBS`, `cuda-libs/` beside the program, the CUDA toolkit folders)
  and reports it when it cannot load it; run `./install-desktop-icon.sh` again (it finds and links a
  cuDNN 9 for CUDA 13; `--cudnn-dir <folder>` names one), or install cuDNN 9, restart UpScape (the
  result is remembered while it runs) and choose the CPU meanwhile. *Automatic* already uses the
  CPU in that case.
- *Windows: a job on the graphics card fails* - choose *CPU* in Settings > Setup... > Device and
  report the message (graphics driver, card). *Automatic* tries the card with one small test tile
  first and goes on with the CPU when that fails; the window's log names the reason.
- *The window is tiny or huge* - the window follows the desktop's scale factor; Settings
  offers fixed sizes (Ctrl+1 to Ctrl+4) and fullscreen (Ctrl+F).
- *Nothing happens when a file is dropped* - Wayland, see above.

## Privacy

UpScape sends nothing anywhere. The only network access is the model download you start in
Setup, to the publishers' addresses. ONNX Runtime contains Microsoft's telemetry client; the
programs switch it off before the runtime is loaded (`ORT_DISABLE_TELEMETRY=1`), and no
telemetry store is created. The Windows package also contains Microsoft's DirectML library
(`LICENSES\directml-*-LICENSE.txt`); its licence has a clause that lets that library collect
usage data. UpScape itself still sends nothing, and the library's own tracing stays on the
machine unless Windows is configured to send it.

## Licences

UpScape's own code is MIT (`LICENSE`). The folder `LICENSES/` carries ONNX Runtime's licence
and third-party notices, the list of Rust libraries with their licences
(`rust-libraries.json`) and the data licences. Model weights keep the licences in the table
above; `onnx/LICENSES/` carries their notices.
