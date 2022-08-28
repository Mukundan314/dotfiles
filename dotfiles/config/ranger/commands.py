import sys
import copy
import subprocess
from collections import namedtuple


# Hacky way to get ranger to use imagemagick for processing images when using kitty backend
class MagickBackend:
    DecompressionBombWarning = NotImplemented
    LANCZOS = NotImplemented

    def __init__(self, path):
        self.path = path
        self.mode = "RGB"
        self.width, self.height = map(
            int,
            subprocess.run(
                ["magick", "identify", "-quiet", "-format", "%w %h", self.path],
                capture_output=True,
                check=True,
            )
            .stdout.decode()
            .split(),
        )

    def resize(self, size, method):
        resized = copy.copy(self)
        resized.width, resized.height = size
        return resized

    def save(self, path, format, compress_level):
        subprocess.run(
            [
                "magick",
                "convert",
                self.path,
                "-quiet",
                "-resize",
                f"{self.width}x{self.height}",
                f"{format}:{path.name}",
            ],
            check=True,
        )

    def convert(self, colorspace):
        raise NotImplementedError

    def getbands(self):
        raise NotImplementedError

    def getdata(self):
        raise NotImplementedError

    @classmethod
    def open(cls, path):
        return cls(path)


sys.modules["PIL"] = namedtuple("PIL", ["Image"])(MagickBackend)  # type: ignore
sys.modules["PIL.Image"] = MagickBackend  # type: ignore
