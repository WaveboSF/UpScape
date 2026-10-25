# Installing UpScape 1.08

Download one package for your operating system from the
[1.08 release](https://github.com/WaveboSF/UpScape/releases/tag/v1.08), together
with its matching `.sha256` file. Both packages store the precise build identity
1.08.03 and display the public release label 1.08.

## Requirements

| Requirement | Windows | Linux |
|---|---|---|
| OS / architecture | Windows 10/11, x64; DirectML requires Windows 10 1903 or later | x86-64 distribution with glibc 2.43+ and libstdc++ providing GLIBCXX 3.4.22 |
| Inference runtime | Included: ONNX Runtime 1.24.4 / DirectML | Included: ONNX Runtime 1.31.0, CPU and CUDA providers |
| Mandatory runtime support | Microsoft Visual C++ runtime; its verified installer is included | System loader and graphical desktop support; the checker reads the actual ELF requirements |
| Optional GPU | Compatible DirectX 12 adapter and current driver | NVIDIA driver supporting CUDA 13, plus CUDA 13 and cuDNN 9 libraries |
| First-use models | Seven original weights and six prepared bundles included | Seven original weights and six prepared bundles included |
| Internet / Python | Neither required for the bundled baseline | Neither required for the bundled baseline |

Available RAM and GPU memory determine usable image/tile sizes. Start with a
small image. GPU discovery alone does not prove that a model calculation works.
CPU processing remains available without optional GPU components. These builds
do not provide Linux AMD/Intel GPU compute or Windows CUDA.

CPU execution reserves the scheduling capacity of two physical cores when
topology is known; otherwise it uses the logical count minus two, with at least
one worker. This limits threads; it cannot guarantee idle cores. CPU-only
Variants requires at least eight verified physical cores and confirmation
because it can run for a long time and stress memory and the system. An integrated
GPU shares system resources; older integrated graphics are not a general
replacement for a dedicated GPU. No future CPU generation is guaranteed here.

## Windows

1. Verify the installer against its checksum:

   ```powershell
   certutil -hashfile UpScape-1.08-windows-x64-setup.exe SHA256
   ```

   Compare the hash with the `.sha256` file.
2. Run `UpScape-1.08-windows-x64-setup.exe`. The installer is currently unsigned;
   Windows may display a SmartScreen warning. Verify the download before choosing
   to continue.
3. Choose a current-user installation or, when running elevated, an all-users
   installation. Setup checks mandatory OS/runtime requirements and can install
   the included Microsoft Visual C++ runtime after verifying its signature.
   Optional GPU support does not block CPU installation.
4. Start UpScape from the Start menu or desktop shortcut. No first-use download
   is needed for the included baseline. The optional, initially unchecked check
   for a newer stable UpScape package keeps the bundled version when offline,
   declined or unsuccessful.

Keep all installed DLLs, data, models and notices together. Settings are under
`%APPDATA%\upscape`; downloaded weights/prepared optional models are under
`%LOCALAPPDATA%\upscape`. Use Apps & features or the Start-menu uninstaller for
removal. It asks before removing user settings and downloaded models.

## Linux

1. Verify and unpack the archive:

   ```sh
   sha256sum -c UpScape-1.08-linux-x86_64.tar.gz.sha256
   tar -xzf UpScape-1.08-linux-x86_64.tar.gz
   cd UpScape-1.08-linux-x86_64
   ```

2. Run the read-only prerequisite checker and start the program:

   ```sh
   ./check-system.sh --report UpScape-system-report.md
   ./UpScape.sh
   ```

   Use a new report filename; reports do not overwrite existing files.
3. Optional desktop/menu shortcuts:

   ```sh
   ./install-desktop-icon.sh
   ```

   The script checks mandatory requirements before changing launchers. Existing
   launchers pointing elsewhere remain unless `--replace` is used, which keeps a
   backup. After moving the program folder, recreate its launchers.

Keep the whole unpacked folder together, including `onnx/`, `weights/`, runtime,
data and `LICENSES/`. This build requires glibc 2.43 or newer; older distributions
cannot run it. Settings are in `~/.config/upscape`; optional downloaded model
data is in `~/.local/share/upscape`.

For CUDA, install compatible NVIDIA driver/CUDA 13/cuDNN 9 components through
their supported distribution channels. UpScape does not install a driver or
change system libraries. `install-desktop-icon.sh` can link an existing cuDNN
installation as `cuda-libs` beside the launcher. You can name it explicitly:

```sh
./install-desktop-icon.sh --cudnn-dir /path/to/nvidia/cudnn/lib
```

`UPSCAPE_CUDA_LIBS` can also name library directories, separated by colons.
An explicitly selected unavailable GPU reports an error; automatic selection
can use CPU and names the reason in the log. On Wayland use **Open image**
instead of drag-and-drop.

To remove shortcuts, use `./uninstall-desktop-icon.sh`. Then remove the unpacked
folder; retain or remove your personal settings/model folders as you choose.

## Check the system after installation

**Info > System info** provides a fresh background snapshot and a table of
**Check / Required / Found / Status / Next step**. Refresh rechecks after a change;
Copy and Save report export it. Unreadable values stay unknown. The report checks
requirements and discovery; it does not run model inference.

## First image, Batch and Save

Open an image, choose an AI model or classical filter, set the factor and process
it. Compare the views and adjust Blend. **Variants** compares alternatives within
the hardware limits above. S1-S8 store reusable setups.

Batch processing reuses the prepared processing choices and selected files.
Choose the source/output folder, check the files, review settings and start.
Watermark and filename controls apply to the outputs. Closing its window keeps
a running batch active; Stop offers its existing stopping choices.

Ctrl+S opens format and filename controls. The Save icon follows the quick-save
preference. Templates can include
`{name}`, `{filter}`, `{blend}`, `{factor}` and `{model}`. Original files remain
protected. The watermark editor provides installed fonts, font-size slider,
position, rotation, colors, opacity and an optional background box. ROI supports
selection, cropping and transparent cutouts; use a format supporting alpha when
saving transparency.

## Optional models and licences

The seven bundled weight files represent six standalone model choices, including
Fast 4x's denoise partner. All are verified against catalogue sizes and SHA-256.
Remacri and UltraSharp are CC-BY-NC-SA-4.0 (NonCommercial), absent from the
packages and disabled by default. Only an explicit in-app request after licence
confirmation fetches their weights and prepares their graph locally. Their
licence restrictions still apply. See [acknowledgements](LICENSES/ACKNOWLEDGEMENTS.md).

## Troubleshooting and privacy

- Missing runtime/model files: repair the complete Windows installation or
  unpack the verified Linux archive again. Start Linux through `UpScape.sh`.
- Missing CUDA/cuDNN: select CPU, check System info and the log, and correct the
  optional system libraries before retrying GPU processing.

Images are processed locally. UpScape uploads no images and disables ONNX Runtime
telemetry before loading it. The Windows DirectML library retains Microsoft's
own licence and Windows tracing behavior. Optional release/model network access
uses the explicitly described request paths. Keep all original software and
model notices with the binary packages.
