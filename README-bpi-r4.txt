# bpi-r4-build-configs
Minimal build fragments for Banana Pi R4 image scripts.
No license restrictions, no warranty.

Directories:
- `boot/` – U-Boot environment helpers that avoid shipping static MAC
  addresses.
- `dts/` – Hardened device-tree sources for the 4 GiB Banana Pi R4.  Common
  peripherals now live in `bpi-r4-hardened-common.dtsi` so both full trees and
  fragments stay in sync.
- `tfa/` – Optional Trusted Firmware-A fragments that enable secure-boot and
  profiling-friendly defaults.

See the relevant script for usage details.
