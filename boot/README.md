# CathodeOS PC boot layer

The CathodeOS PC boot layer is responsible for turning the Android x86_64
product into a UEFI-bootable ISO and for exposing both live and installation
modes.

## Design

The first public ISO is intended to expose this flow:

```
UEFI firmware
    |
    v
 GRUB 2
    |
    +--> Try CathodeOS
    |
    +--> Install CathodeOS
    |
    +--> CathodeOS (Safe Graphics)
    |
    +--> Advanced options
    |
    +--> Firmware setup
    +--> Reboot
```

The installer is intentionally a separate Linux environment. CathodeOS
itself remains the Android userspace; the installer environment is responsible
for disk discovery, partitioning, filesystem creation, copying the Android
payload, and configuring the UEFI boot path.

## Installation modes

The installer must support:

1. Erase disk and install CathodeOS.
2. Install alongside an existing operating system.
3. Manual partitioning.

The "alongside" path is a real installation mode, not an instruction to
manually repartition the disk. It must detect existing OS installations and
available space, offer a safe resize/install plan, and preserve the existing
EFI System Partition when possible.

## Media layout

The boot menu references a stable media contract:

```
/cathode/boot/bzImage
/cathode/boot/initrd.img

/cathode/installer/bzImage
/cathode/installer/initrd.img
/cathode/installer/rootfs.squashfs

/cathode/system/...
```

The exact Android system payload and kernel packaging may change during bring-up;
the paths above are the ISO-level interface that the future image builder should
populate.

## Design ancestry

The architecture is intentionally similar to the modern Android-PC approach:
a GRUB front end plus a small Linux installation environment. BlissOS's
Ānanda Āropa project currently uses a Devuan-based installation environment
with Calamares, GParted and other maintenance tools. CathodeOS may reuse the
same general strategy, but Cathode-specific configuration and installation
logic should remain separate rather than copying another project's branding
or implementation.

No third-party installer code is vendored by this change.
