# Inconsistencies in `brms` predictions for spline models

Minimal reproducible example to demonstrate significant inconsistencies sometimes seen in predictions of [`brms`](https://paul-buerkner.github.io/brms/) spline models in different environments.

 - Run `renv::restore()` to set up the package environment.
 - Minimal example: `/scripts/mortality.R`, rename output as appropriate.
 - Models trained in different environments are located in `/models`.
 - Analysis scripts are located in `/scripts`.
 - Plots of cluster and Ubuntu models in both environments are located in `/plots`.

## Summary of results

|Training Environment |R-sq cluster_R4_1_1 |R-sq debian_R3_6_3 |R-sq macos_R4_1_1 |R-sq ubuntu_R4_1_1 |R-sq windows_R4_1_1 |
|:--------------------|:-------------------|:------------------|:-----------------|:------------------|:-------------------|
|cluster_R3_6_3       |0.99823444          |0.99823444         |0.48131956        |0.48131956         |0.48131956          |
|cluster_R4_1_1       |0.99823444          |0.99823444         |0.48131956        |0.48131956         |0.48131956          |
|cluster_R4_1_3       |0.99823444          |0.99823444         |0.48131956        |0.48131956         |0.48131956          |
|debian_R3_6_3        |0.99823289          |0.99823289         |0.48123877        |0.48123877         |0.48123877          |
|macos_R4_1_1         |0.48348136          |0.48348136         |0.99823370        |0.99823370         |0.99823370          |
|ubuntu_R4_1_1        |0.48346169          |0.48346169         |0.99823124        |0.99823124         |0.99823124          |
|windows_R4_1_1       |0.48343821          |0.48343821         |0.99823314        |0.99823314         |0.99823314          |

### BLAS/LAPACK library implementations used in our environments
 - Ubuntu uses the R-internal "reference (Fortran) implementation" `libRblas.so` and `libRlapack.so`.
   - Appears to be derived from the Netlib implementation (version unknown) with some "tuning".
 - Debian uses `libopenblasp-r0.3.5.so`.
   - An OpenBLAS pthread implementation version 0.3.5 (includes optimised LAPACK, version unknown).
 - The cluster uses `libsci_gnu_82_mp.so.5.0` from module `cray-libsci/20.09.1`
   - Appears from Module help to be Netlib LAPACK 3.6.1, BLAS version unknown.
 - Windows and macOS use the R-internal implementations `libRblas.so` and `libRlapack.so`.
