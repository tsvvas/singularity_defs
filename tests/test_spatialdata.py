import zipfile
from pathlib import Path
from urllib.request import urlretrieve
from urllib.error import URLError

import pytest
import spatialdata as sd

MOUSE_LIVER_ZIP = "https://s3.embl.de/spatialdata/spatialdata-sandbox/mouse_liver.zip"


def test_write_read_roundtrip(tmp_path: Path):
    sdata = sd.SpatialData()
    out = tmp_path / "tmp.zarr"
    sdata.write(out)
    loaded_sdata = sd.read_zarr(out)
    assert isinstance(loaded_sdata, sd.SpatialData)
    assert "table" not in loaded_sdata.tables


@pytest.mark.skip(reason="Temporarily disabled")
def test_read_mouse_liver_from_remote_zip(tmp_path: Path):
    zip_path = tmp_path / "mouse_liver.zip"
    try:
        urlretrieve(MOUSE_LIVER_ZIP, zip_path)
    except URLError as e:
        pytest.fail(f"Network not available or download failed: {e}")

    try:
        with zipfile.ZipFile(zip_path, "r") as zf:
            zf.extractall(tmp_path)
    except zipfile.BadZipFile as e:
        pytest.fail(f"Downloaded file is not a valid ZIP: {e}")

    zarr_path = tmp_path / "data.zarr"
    if not zarr_path.exists():
        pytest.fail("Expected 'data.zarr' at archive root; layout may have changed.")

    sdata = sd.read_zarr(zarr_path)

    assert isinstance(sdata, sd.SpatialData)
    assert any(
        [
            bool(getattr(sdata, "images", {})),
            bool(getattr(sdata, "labels", {})),
            bool(getattr(sdata, "points", {})),
            bool(getattr(sdata, "shapes", {})),
            getattr(sdata, "table", None) is not None,
        ]
    ), "Loaded SpatialData appears empty."
