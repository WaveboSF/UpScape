# UpScape 0.90.32 beta - release notes

First public build of the native Rust version (2026-10-21). It reproduces the Python
reference program UpScape 0.90.32 as one native program without a Python runtime: the
window, the command line, ONNX Runtime inference, file formats, metadata, settings and the
four setups. How to install and start it: [INSTALL.md](../INSTALL.md).

## Archives

| File | Size | SHA-256 |
|---|---|---|
| `UpScape-0.90.32-beta-linux-x86_64.tar.gz` | 262 MB | `f569d8c0c100756848ef4a99edfddf9243911b36f2853ff588df01a46f221d19` |
| `UpScape-0.90.32-beta-windows-x86_64.zip` | 34 MB | `6bc2e7f330c6a8b73bfbec071cfcc461506a3135d268091d52a6ca09461309f0` |
| `UpScape-0.90.32-beta-models-onnx.zip` | 413 MB | `ac9f9c39a15ff3bcfb767f7c5d39caec7e36a82d4a5467799e034a263130e8e3` |

Built from UpScape_Rust commit 70afbbf; the Python reference (program files) is commit
45813a0, version 0.90.32. The Linux archive holds `upscape`, `upscape-window`, ONNX Runtime
1.31.0 with its CUDA provider, the data files, licences, `UpScape.sh`, `INSTALL.md`. The
Windows archive holds `UpScape.exe` (window, no console), `upscape.exe` (command line), ONNX
Runtime 1.31.0 (CPU), data, licences, `INSTALL.md`. The models archive holds one `onnx/`
folder with the prepared graphs (fp32 and fp16) and manifests of the six redistributable
models plus the denoise-partner artifact, with their licence notices.

## What was verified

- The Rust test suite on the CPU at adaac10 (70afbbf changes scripts, licences and documents only): 178 tests in 39 binaries, 0 failed, 1 ignored
  (a timing probe); `cargo fmt --check` and `cargo clippy -D warnings` clean.
- Numerics against the Python reference (the author's comparison report): classical resampling,
  blend, quantisation, adjustments, naming and metadata reproduce the reference's golden
  values; AI results differ from PyTorch by at most 1 code in the saved 8-bit file (ONNX
  Runtime kernels); JPEG decoding differs by up to 10 codes on 4:2:0 input (a different
  decoder).
- The Variants grid computes a true excerpt of the full result: more than 100 windows
  across factors 0.5, 1.1 and 4, both AI inputs, image edges and 1x1 windows, with and
  without a region, equal the full computation within 2e-5.
- The Linux release was installed as INSTALL.md describes (models unpacked into `onnx/`)
  and run on a synthetic 16-bit image on the CPU; Setup lists the six shipped models as
  ready and the two NonCommercial ones as missing (docs/screenshot.png).
- The Windows build under Wine: `upscape.exe --version` reports "UpScape 0.90.32 beta"; an
  earlier same-day build upscaled pixel-identically to the Linux build. Not yet run on a real
  Windows machine.
- A re-verification of the development handover's claims by 16 independent checkers with
  skeptic panels is recorded in the author's verification record (dev/VERIFY_2026-10-21.md in the source repository); no GPU run was part of it.

## Known limitations and deviations from the reference

- Windows: CPU only; cross-compiled; not code-signed; fonts come from `%WINDIR%\Fonts`
  (unverified on real Windows).
- Linux: needs glibc 2.43 (built on Ubuntu 26.04); on Wayland the window does not receive
  dropped files yet (the empty Original says so); the desktop may ignore requested window
  sizes (Ctrl+1 to Ctrl+3) and maximise instead of filling the work area.
- The two NonCommercial models (Remacri 4x, UltraSharp 4x) are listed but have no
  distributed prepared graph; starting one reports the missing graph.
- In the 2x2 grid the lower view headers can overlap their role label at 1920 px width (the
  metadata string is not elided yet; see docs/screenshot.png).
- Dialogs are drawn inside the window; number fields have no spin arrows; the busy cursor
  is painted at the pointer; the Library-licences browser of the reference is not built
  (the texts are in `LICENSES/`); clipboard pictures and the long-job tray notice are not
  built.
- JPEG encoding and TIFF tag layout differ from the reference's libraries at equal
  quality; the watermark's glyphs are rasterised by a different engine (box 2-3 px
  narrower).

## Privacy

ONNX Runtime's Microsoft telemetry client is switched off by the programs before the
runtime loads (`ORT_DISABLE_TELEMETRY=1`); verified: no telemetry store is created. The
only network access is the model download you start in Setup, to the publishers' addresses.
