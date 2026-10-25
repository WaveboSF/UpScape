# Acknowledgements

## Upscayl: inspiration and selected aspects of model research

[Upscayl](https://github.com/upscayl/upscayl) was one of the inspirations for
UpScape. During early model research, we studied selected aspects of its
publicly available source, model catalogue and handling of packaged model files.
This helped us identify and compare some of the available AI model choices.

We warmly thank the Upscayl team and all contributors for building this project,
sharing their code and practical knowledge, and making AI image enlargement
accessible to a wider community.

## AI model authors

UpScape relies on the work of the authors below. We thank them for developing
and publishing their trained models and weights. Their work makes the AI
enlargement possible; UpScape provides its own processing and comparison tools
around those models.

The credits include every model in UpScape's catalogue, including the denoise
partner and optional models. Names, authors, homepages and licences are generated
from the shared model catalogue. A download mirror's account name is not used
as the model author's name.

| Model | Catalogue ID | Author and model source | Licence | Availability |
|---|---|---|---|---|
| General 4x | realesrgan-x4plus | [Xintao Wang et al.](https://github.com/xinntao/Real-ESRGAN) | BSD-3-Clause | Prepared ONNX model included |
| Conservative 4x | realesrnet-x4plus | [Xintao Wang et al.](https://github.com/xinntao/Real-ESRGAN) | BSD-3-Clause | Prepared ONNX model included |
| General 2x | realesrgan-x2plus | [Xintao Wang et al.](https://github.com/xinntao/Real-ESRGAN) | BSD-3-Clause | Prepared ONNX model included |
| Fast 4x | realesr-general-x4v3 | [Xintao Wang et al.](https://github.com/xinntao/Real-ESRGAN) | BSD-3-Clause | Prepared ONNX model included |
| Fast 4x (denoise partner) | realesr-general-wdn-x4v3 | [Xintao Wang et al.](https://github.com/xinntao/Real-ESRGAN) | BSD-3-Clause | Included denoise partner |
| Drawing 4x | realesrgan-x4plus-anime-6b | [Xintao Wang et al.](https://github.com/xinntao/Real-ESRGAN) | BSD-3-Clause | Prepared ONNX model included |
| High fidelity 4x | 4x-hfa2k | [helaman (Philip Hofmann)](https://openmodeldb.info/models/4x-HFA2k) | CC-BY-4.0 | Prepared ONNX model included |
| Remacri 4x | 4x-remacri | [foolhardy](https://openmodeldb.info/models/4x-Remacri) | CC-BY-NC-SA-4.0 | Optional download; not bundled (NonCommercial) |
| UltraSharp 4x | 4x-ultrasharp | [kim2091](https://openmodeldb.info/models/4x-UltraSharp) | CC-BY-NC-SA-4.0 | Optional download; not bundled (NonCommercial) |

The original model weights retain their authors' licences. Prepared ONNX graphs
are format conversions of those weights, without retraining or fine-tuning on
microscope images. Remacri and UltraSharp are optional NonCommercial models:
their weights and prepared graphs are not included in the distributed package.
After licence confirmation, their weights are downloaded and their graphs are
prepared on the user's own computer.

These acknowledgements accompany the applicable licence texts and copyright
notices; they do not replace them. UpScape's own code, third-party software and
AI models retain their respective licences. See LICENSE (LICENSE.txt on Windows),
LICENSES/ and onnx/LICENSES/ in the program package.
