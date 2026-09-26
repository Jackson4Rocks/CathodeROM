# CathodeROM Roadmap

## Phase 0 — Source bring-up

- [x] Create the CathodeROM x86_64 product repository
- [x] Pin AOSP to Android 16.0.0 Release 4
- [x] Add a Repo bootstrap script
- [ ] Verify product discovery with `lunch cathoderom_x86_64-userdebug`

## Phase 1 — First PC boot

- [ ] Select a PC kernel strategy
- [x] Define the UEFI/GRUB ISO boot contract
- [x] Add the initial CathodeOS GRUB menu
- [x] Define live and installer boot modes
- [ ] Add UEFI boot artifacts
- [ ] Package an initramfs
- [ ] Produce a bootable disk/ISO artifact
- [ ] Boot under QEMU
- [ ] Validate "Try CathodeOS" from removable media

## Phase 2 — Real laptop hardware

- [ ] Intel graphics
- [ ] AMD graphics
- [ ] Wi-Fi
- [ ] Bluetooth
- [ ] Audio
- [ ] Touchpad and HID
- [ ] Backlight
- [ ] Battery/ACPI
- [ ] Suspend/resume
- [ ] Webcam

## Phase 3 — Laptop experience

- [ ] Desktop-friendly SystemUI
- [ ] Windowed app behavior
- [ ] Keyboard shortcuts
- [ ] Power profiles
- [ ] Display hotplug
- [ ] External monitor support

## Phase 2 — Installer

- [ ] Build the minimal Linux installer environment
- [ ] Integrate Calamares or an equivalent mature installer framework
- [ ] Add CathodeOS-specific installation modules
- [ ] Implement erase-disk installation
- [ ] Implement install-alongside-existing-OS
- [ ] Implement controlled partition resizing
- [ ] Implement manual partitioning
- [ ] Install/configure UEFI boot files and GRUB
- [ ] Preserve and rediscover existing operating systems
- [ ] Add destructive-operation confirmations and failure-safe checks
- [ ] Test Windows + CathodeOS dual boot
- [ ] Test Linux + CathodeOS dual boot

## Phase 3 — Real laptop hardware

- [ ] Intel graphics
- [ ] AMD graphics
- [ ] Wi-Fi
- [ ] Bluetooth
- [ ] Audio
- [ ] Touchpad and HID
- [ ] Backlight
- [ ] Battery/ACPI
- [ ] Suspend/resume
- [ ] Webcam

## Phase 4 — Laptop experience

- [ ] Desktop-friendly SystemUI
- [ ] Windowed app behavior
- [ ] Keyboard shortcuts
- [ ] Power profiles
- [ ] Display hotplug
- [ ] External monitor support

## Phase 5 — Distribution

- [ ] Reproducible builds
- [ ] Release signing model
- [ ] OTA/update strategy
- [ ] Release artifacts
- [ ] Release documentation and recovery guidance
