# bpi-r4-build-configs

Minimal build fragments for Banana Pi R4 image scripts.
No license restrictions, no warranty.

## Boot profile workflow

The U-Boot pieces under `boot/` are now selected through profiles.  Run
`./boot/select-profile.sh <profile>` before regenerating `boot.scr` or
building a U-Boot image.  The script updates the symlinks in `boot/` so
existing build scripts keep working.

Available profiles:

* `development` (default) – retains the interactive shell and boot menu,
  keeps the persistent environment on the FAT partition, exposes the full
  UART console, and leaves custom overlays enabled for rapid iteration.
* `lockdown` – removes interactive escape hatches by default and prepares a
  read-only environment for production images.

Re-run the script with `development` to switch back from a lockdown build.

## Lockdown profile details

The lockdown profile makes the following changes compared to development:

* U-Boot environment is built-in only (`CONFIG_ENV_IS_NOWHERE`) and the
  `saveenv` path is disabled.
* Boot delay is forced to zero and the boot menu command set is removed so
  there is no chance to drop into a shell during autoboot.
* Only the serial console is left enabled for log output.  The console is
  silenced during relocation to keep output minimal.
* Network, USB host, PCI, and miscellaneous utility commands are stripped
  from the command table to shrink the trusted computing base.
* The boot flow attempts `boot.scr` first, then performs a direct MMC boot,
  and finally issues a reset if neither path succeeds.

Optional hardware-assisted unlocking is available.  Provide a command that
returns success when the desired physical condition is met (for example a
GPIO strap) by exporting it through `lockdown_unlock_cmd` in `boot.scr` or a
custom image.  When that command succeeds the boot flow will attempt to run
`lockdown_unlock_payload` if it exists, otherwise it loads `unlock.scr`
from the same FAT partition.  This keeps recovery tooling outside of the
normal boot path and tied to a physical action.

## Development profile details

The development profile matches the previous behaviour: boot delay -2,
interactive boot menu, environment saved to `mmc 0:5`, and a preboot hook
that launches the menu when `boot.scr` is absent.

See the profile fragments in `boot/profiles/` for the exact configuration.
