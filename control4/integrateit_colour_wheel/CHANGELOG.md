# Changelog — IntegrateIT Colour Wheel

## [0.1.2] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.1.1] - 2026-07-20
Adversarial review of the first cut. Six defects, all with regression cases.
- **Next Hue / Previous Hue were dead buttons under a custom hex.** `Custom Colour (Hex)` outranks the hue stop in the resolve spine, so a step moved the property, fired *Hue Stop Changed*, and pushed the same colour — the picker announced a stop the room did not show. A step now retires the override and says so; pressing a hue button is an explicit request for a named stop.
- **Property echoes applied a second time.** `C4:UpdateProperty` calls back into `OnPropertyChanged` on a controller, which the simulator's stub does not model. A preset recall writes six watched properties before its own deliberate apply — seven colour pushes and seven *Colour Applied* events for one press, 42 proxy commands across six lights. Internal writes now run under a re-entrancy guard that `OnDevicePropertyChanged` honours.
- **A recall of a legacy or truncated preset could error mid-restore.** `PersistData` outlives the code that wrote it; stored fields went straight to `UpdateProperty`, where a nil throws and a `tostring(nil)` leaves the literal string "nil" in a dealer's property. Every field is now coerced and clamped, and a non-table slot reads as empty.
- **A custom hex named itself with its hex code.** "Custom #4488CC" is a value, not a name, and a speakable name is this driver's entire accessibility premise. Custom colours now name themselves by nearest named stop ("Custom Azure"); the exact value stays in `COLOUR_HEX`.
- **Brighter / Dimmer were silently invisible with `Set Light Level` = No.** Brightness only reaches a fixture through the level ramp. The step is still recorded and published, but `Status` now admits no level was sent instead of reporting a colour push.
- **The Colour-Vision-Safe 6 claim overclaimed.** Six hues on the blue-yellow axis survive red-green deficiency far better than the full ring, but they are not mutually distinguishable under dichromacy — Amber/Yellow and Cyan/Azure/Blue differ mainly in lightness. Catalog copy, limitations, and documentation now say what is true, and name the published `COLOUR_NAME` as the guarantee that actually holds. Two further real limitations documented: the hue-step/hex interaction, and that presets are controller-local because `PersistData` is not carried in a project export.

## [0.1.0] - 2026-07-20
- First cut. An accessible colour picker for Control4 colour-capable lights: twelve named hue stops on a perceptually-spaced ring, walked with single-shot Next Hue / Previous Hue commands rather than a two-dimensional wheel, plus a Colour-Vision-Safe 6 ring for red-green colour deficiency.
- One conversion spine — hue stop, saturation, custom hex, or Kelvin all resolve to a single (CIE 1931 xy, brightness) sample — feeding the sRGB hex readout, the HSV numbers, the nine published variables, and the proxy payload, so no two surfaces can disagree about the selected colour.
- Drives up to six bound lights over the Control4 colour proxy contract: SET_COLOR_TARGET with CIE xy at colour mode 0 or Kelvin at colour mode 1, plus an optional RAMP_TO_LEVEL at the configured transition rate.
- Four presets in PersistData that survive a controller reboot; Warmer / Cooler / Brighter / Dimmer steppers with range clamping; Announce Colour as an unlicensed-safe readout.
- Colour reports from the lights are recorded as a passive readout and never re-applied, so the driver cannot ping-pong against a fixture.
- Boot publishes the readouts but drives no light: a Director restart never repaints a room the homeowner set by hand.
- Every control path is gated on the shared MAC-locked LicenseGate().
