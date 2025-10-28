# Trusted Firmware-A fragments

This directory contains small, opt-in configuration fragments that tighten the
Trusted Firmware-A build used on the Banana Pi R4.  They are intended to be
included from the main TF-A make invocation, for example:

```
make -f Makefile -f tf-a/bpi-r4-secure.mk \
     PLAT=mt7988 ARM_TSP_RAM_LOCATION=dram \
     BL33=/path/to/u-boot.bin fip
```

The [`bpi-r4-secure.mk`](./bpi-r4-secure.mk) snippet keeps the board in the
`RESET_TO_BL31` flow, enables the Certificate of Trust chain, and turns on
run-time instrumentation so regressions are easier to spot.  Because the values
are assigned with `?=`, downstream consumers can still override specific
settings without editing this repository.

> **Note**
> Enabling `TRUSTED_BOARD_BOOT` requires supplying valid signing keys.  Refer to
> the upstream TF-A documentation for provisioning guidance before shipping a
> secure build.
