# CathodeROM

**CathodeROM** is an Android 16-based operating system for generic x86_64 laptops and PCs.

The project starts from AOSP and adds a PC-oriented device layer. The goal is a real UEFI-bootable Android image, not a phone GSI transplanted onto a laptop.

## Project status

This repository is in the bring-up stage.

- Android base: AOSP 16.0.0 Release 4
- Target architecture: x86_64
- Initial product: `cathoderom_x86_64`
- Boot target: UEFI PC/laptop
- Hardware bring-up: in progress
- GPU/audio/Wi-Fi/suspend tuning: not yet complete

## Build model

The repository is intentionally small. AOSP itself is fetched by Repo, while this repository supplies CathodeROM-specific files through a local manifest.

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
CathodeROM x86_64 image
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
lunch cathoderom_x86_64-userdebug
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
8. Add reproducible image builds and release artifacts.

## License

CathodeROM-specific code is intended to be Apache-2.0 unless a file states otherwise. AOSP and third-party components retain their original licenses.
