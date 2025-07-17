import spatialdata as sd
from pathlib import Path


def test_write_read_roundtrip(tmp_path: Path):
    sdata = sd.SpatialData()
    out = tmp_path / "tmp.zarr"
    sdata.write(out)
    loaded_sdata = sd.read_zarr(out)
    assert isinstance(loaded_sdata, sd.SpatialData)
    assert loaded_sdata.table is None
