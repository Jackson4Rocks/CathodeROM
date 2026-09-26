# CathodeROM Roadmap

## Phase 0 — Source bring-up

- [x] Create the CathodeROM x86_64 product repository
- [x] Pin AOSP to Android 16.0.0 Release 4
- [x] Add a Repo bootstrap script
- [ ] Verify product discovery with `lunch cathoderom_x86_64-userdebug`

## Phase 1 — First PC boot

- [ ] Select a PC kernel strategy
- [ ] Add UEFI boot artifacts
- [ ] Package an initramfs
- [ ] Produce a bootable disk/ISO artifact
- [ ] Boot under QEMU

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

## Phase 4 — Distribution

- [ ] Reproducible builds
- [ ] Release signing model
- [ ] Installer
- [ ] OTA/update strategy
- [ ] Release artifacts
