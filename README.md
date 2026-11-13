# customtwrps

Custom TWRP builds for devices that don't have an official one.
One folder per device under `device/<brand>/<codename>/`, one GitHub
Actions workflow per device under `.github/workflows/`.

> ⚠️ **Vibecoded:** this repo was built with AI assistance. Expect rough edges — bug reports welcome.

## Devices

| Device | Codename | Android | Chipset | Status |
|---|---|---|---|---|
| Vortex T10M | `along/T10` | 12 | MediaTek MT8766B (mt6761) | ✅ Built — see [releases](https://github.com/vibecodeboredom/customtwrps/releases) |

## Vortex T10M

- **Device tree:** `device/along/T10/` — generated with [twrpdtgen](https://github.com/twrpdtgen/twrpdtgen) 3.0.0 from the stock `boot_a.img` of firmware `VORTEX_T10M_MT8766B_A12.0`, then adapted for the minimal-manifest AOSP build (`twrp_` product naming, `PLATFORM_VERSION 12.1.0`).
- **Build:** GitHub Actions workflow `.github/workflows/build-t10m.yml` — syncs `minimal-manifest-twrp/platform_manifest_twrp_aosp` (`twrp-12.1`), copies in the tree, `lunch twrp_T10-eng`, `mka bootimage`.
- **Output:** `boot.img` — the T10M is an A/B device with recovery-as-boot, so the boot image **is** the recovery. It is delivered as `recovery.img` in the release for clarity.
- **Test it (does NOT flash):**
  ```
  fastboot boot recovery.img
  ```
  This boots TWRP once. Only flash it (`fastboot flash boot_a recovery.img` + `fastboot flash boot_b recovery.img`) after confirming it boots and touch works.
- **vbmeta:** the stock `vbmeta_a.img`/`vbmeta_b.img` enforce verified boot. If the device refuses to boot the custom image, flash vbmeta with verification disabled first:
  ```
  fastboot --disable-verity --disable-verification flash vbmeta_a vbmeta_a.img
  fastboot --disable-verity --disable-verification flash vbmeta_b vbmeta_b.img
  ```
  (Use the stock vbmeta images from the `VORTEX_T10M_MT8766B_A12.0` firmware.)
- **GApps:** the T10M kit bundles `MindTheGapps-12.0.0-arm64-20220128_095253.zip` (ARM64, Android 12) separately — it is **not** in this repo (235 MB). OpenGApps has no Android 12 build, so MindTheGapps is the Android 12 equivalent. Flash it from TWRP after a custom ROM, before first boot.

## Adding a new device

1. Generate the tree with twrpdtgen from the stock boot/recovery image.
2. Put it at `device/<brand>/<codename>/`, adapted for the AOSP manifest (`twrp_` product name, `vendor/twrp/config/common.mk`).
3. Copy `.github/workflows/build-t10m.yml` to `build-<codename>.yml` and change the device path, lunch target, and output.
4. Push — the workflow builds on GitHub Actions and uploads the image as an artifact.
