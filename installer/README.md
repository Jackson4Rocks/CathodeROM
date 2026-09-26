# CathodeOS installer

The CathodeOS installer is a small Linux environment shipped inside the
bootable ISO. It exists so the Android system does not need to become a disk
partitioning application.

## Installer goals

The installer must provide three primary choices:

### Erase disk

Wipe the selected disk and install CathodeOS from scratch.

Before destructive operations, show the exact device, detected model, current
partition count, and the approximate amount of data that will be destroyed.
Require an explicit confirmation.

### Install alongside another OS

Detect existing operating systems, EFI System Partitions, filesystems and
available/unallocated space.

The installer should be able to:

- identify common existing operating systems;
- prefer existing free space when enough space already exists;
- offer a controlled resize of an existing partition when necessary;
- create CathodeOS partitions in the resulting free space;
- preserve the existing EFI System Partition when possible;
- add CathodeOS to the UEFI boot path;
- keep existing bootable operating systems discoverable.

The user must see the proposed partition changes before anything is written.

### Manual partitioning

Expose the partition layout for users who want complete control.

The installer should allow the user to choose the EFI System Partition and
CathodeOS target filesystem explicitly rather than guessing.

## Installer environment

The first implementation should use a mature Linux installer stack instead of
reimplementing partition management from scratch.

The current design target is:

```
minimal Linux rootfs
      |
      +-- Calamares
      +-- partitioning tools
      +-- filesystem utilities
      +-- UEFI/GRUB tooling
      +-- CathodeOS installation module
```

A customized Calamares configuration/module set is preferable to a bespoke
GTK/Qt installer because the difficult parts are disk probing, resize safety,
filesystem handling, EFI setup, and rollback/error reporting.

## Future module boundaries

The installer should eventually have clear modules for:

```
01  Welcome / mode selection
02  Existing OS detection
03  Disk selection
04  Partition plan
05  Partitioning / resize
06  Filesystem creation
07  CathodeOS payload deployment
08  EFI + GRUB setup
09  Boot entry registration
10  Completion / reboot
```

The alongside-install path should fail closed: if the proposed resize or
partition state cannot be verified safely, it must stop and require manual
partitioning instead of guessing.

## Current status

This directory defines the installer contract and UI/flow. The actual
Calamares packaging and CathodeOS-specific install modules will be added after
the x86_64 kernel, initrd and Android image layout are working.
