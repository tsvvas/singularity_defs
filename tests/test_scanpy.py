from pathlib import Path

import pytest
import scanpy as sc

sc.settings.datasetdir = Path("/tmp")


@pytest.fixture(scope="module")
def adata():
    return sc.datasets.pbmc3k()


def test_scanpy_neighbors_on_pbmc(adata):
    sc.pp.pca(adata)
    sc.pp.neighbors(adata, n_neighbors=5, n_pcs=15)
    assert "neighbors" in adata.uns
