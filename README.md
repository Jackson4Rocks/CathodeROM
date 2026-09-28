# CathodeOS

**CathodeOS** is an Android 16-based operating system for generic x86_64 laptops and PCs, built from the CathodeROM source project.

The project starts from AOSP and adds a PC-oriented device layer. The goal is a real UEFI-bootable Android image, not a phone GSI transplanted onto a laptop. CathodeOS keeps the AOSP experience close to stock while layering its own branding, original Pixel-inspired icons, and a PC-focused identity.

## Project status

This repository is in the bring-up stage.

- Android base: AOSP 16.0.0 Release 4
- Target architecture: x86_64
- Initial product: `cathoderom_x86_64`
- Services: microG (FOSS Google API compatibility)
- Boot target: UEFI PC/laptop
- Hardware bring-up: in progress
- GPU/audio/Wi-Fi/suspend tuning: not yet complete

## PC hardware profiles

CathodeOS now has two x86_64 bring-up paths:

- `cathoderom_x86_64`: the original AOSP/generic product used for userspace bring-up.
- `cathoderom_pc_x86_64`: a separate LineageOS-based PC profile that consumes the current
  LineageOS 23.2 minimal x86_64 PC hardware stack. This profile is intended to provide
  the initial PC kernel/ramdisk/filesystem/GRUB plumbing without requiring CathodeOS to
  reimplement the low-level PC layer.

The Lineage profile is synced into a separate `lineage/` checkout so the working AOSP tree
is not destroyed or converted in place.

To prepare it:

```bash
bash ./tools/bootstrap-lineage.sh
```

Then build from the Lineage checkout with:

```bash
cd lineage
source build/envsetup.sh
lunch cathoderom_pc_x86_64 trunk_staging userdebug
TMPDIR="$PWD/.tmp" m -j1
```

The initial PC profile uses LineageOS's minimal x86_64 PC path and its virtio kernel mode.
The broader mainline/generic hardware profile remains the next hardware-expansion step.

## Build model

The repository is intentionally small. AOSP itself is fetched by Repo, while this repository supplies CathodeOS-specific files through a local manifest.

```text
AOSP 16.0.0_r4
      +
CathodeROM device tree
      +
PC kernel / boot integration
      +
Laptop hardware configuration
      |
      v
CathodeOS x86_64 image
```

## Quick start

Run the bootstrap script from this repository on a Linux build host:

```bash
./tools/bootstrap.sh
```

Then enter the AOSP tree and build the first product:

```bash
cd aosp
source build/envsetup.sh
lunch cathoderom_x86_64-trunk_staging-userdebug
./tools/build.sh
```

The default build uses 24 parallel jobs. Override it with `CATHODEROM_BUILD_JOBS=<N> ./tools/build.sh`. The first bring-up build is expected to require additional kernel/boot work before it becomes a bootable laptop ISO.

## Roadmap

1. Sync AOSP 16.0.0_r4.
2. Register the CathodeROM x86_64 product.
3. Boot a minimal Android userspace under a PC-compatible kernel.
4. Produce a UEFI bootable image.
5. Bring up Intel/AMD graphics.
6. Bring up audio, Wi-Fi, Bluetooth, touchpads, webcams and suspend/resume.
7. Add a desktop-oriented SystemUI/launcher and laptop power behavior.
9. Finish CathodeOS branding, Pixel-inspired original icons, boot animation, wallpapers and About page.
8. Add reproducible image builds and release artifacts.

## Copyright and attribution

Copyright © 2026 JacksonTech. CathodeOS branding and CathodeROM-original project materials are copyright by JacksonTech unless a file states otherwise.

AOSP and all third-party components retain their respective copyrights and licenses. See individual source trees and license files for their applicable terms.

## License

CathodeROM-specific code is intended to be Apache-2.0 unless a file states otherwise. AOSP and third-party components retain their original licenses.
