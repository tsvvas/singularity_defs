from pathlib import Path

import pytest
import scanpy as sc
import scvi

sc.settings.datasetdir = Path("/tmp")


@pytest.fixture(scope="module")
def adata():
    return sc.datasets.pbmc3k()


def test_scvi_smoketest(adata):
    scvi.model.SCVI.setup_anndata(adata, batch_key=None)
    model = scvi.model.SCVI(adata, n_latent=2, n_layers=1)
    model.train(max_epochs=1, enable_progress_bar=False)
    assert model.is_trained
