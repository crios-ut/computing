# Conda

Create a conda environment with the environment file
```python
conda env create -f py38.yaml
```
this has many packages, and is focused on MITgcm users.

## xarray demos

These notebooks must be run on Sverdrup:
- [plot_ecco_ctds.ipynb](plot_ecco_ctds.ipynb): read and plot a subset of
  observational data used in the ECCOv4r4 product
- [xarray_demo_crios.ipynb](xarray_demo_crios.ipynb): some of @timothyas's
  favorite features of xarray on display
