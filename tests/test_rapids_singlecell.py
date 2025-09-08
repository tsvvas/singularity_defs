import numpy as np
import pytest
import scanpy as sc
import torch


@pytest.fixture(scope="module")
def adata():
    return sc.datasets.pbmc3k()


@pytest.mark.skipif(not torch.cuda.is_available(), reason="CPU only node")
def test_cudf_roundtrip():
    import cudf
    import cupy
    
    x = cupy.arange(6, dtype=cupy.float32)
    df = cudf.DataFrame({"x": x})
    assert df.x.sum() == 15.0


@pytest.mark.skipif(not torch.cuda.is_available(), reason="CPU only node")
def test_rsc_gpu_loading(adata):
    import cudf
    import cupy
    import cupyx
    import rapids_singlecell as rsc

    adata.obs["cell_id"] = np.arange(adata.n_obs)
    rsc.get.anndata_to_GPU(adata)

    assert isinstance(adata.X, (cupy.ndarray, cupyx.scipy.sparse.spmatrix))
    assert isinstance(adata.obs, cudf.DataFrame)
    assert isinstance(adata.var, cudf.DataFrame)

