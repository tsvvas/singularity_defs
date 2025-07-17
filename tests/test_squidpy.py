import pytest
import squidpy as sq


@pytest.fixture(scope="module")
def adata(tmp_path_factory):
    tmp_path = tmp_path_factory.mktemp("imc_data")
    return sq.datasets.imc(path=tmp_path)[:100]


def test_import():
    assert sq.__version__


def test_spatial_neighbors(adata):
    sq.gr.spatial_neighbors(adata)
    assert "spatial_neighbors" in adata.uns
    assert adata.obsp.get("spatial_connectivities") is not None
