# CathodeOS branding

CathodeOS keeps the AOSP visual language and interaction model as the baseline.
Branding is intentionally implemented as a product/device overlay so it stays
separate from the upstream Android source.

## Current pass

- Product identity: CathodeOS
- Services identity: CathodeOS + microG
- About entry: About CathodeOS
- About icon: original CathodeOS geometric mark
- Accent token: `cathode_accent`
- Icon direction: clean, geometric, Pixel-inspired but original

## Planned assets

```text
branding/
├── icons/
│   ├── cathodeos mark
│   └── system icon set
├── wallpapers/
├── bootanimation/
└── sounds/
```

The first release should keep AOSP SystemUI largely intact. More extensive
desktop/laptop UX changes come after the first bootable x86_64 image.
