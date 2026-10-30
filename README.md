# Welding Cell Sequence Control (CODESYS)

PLC program in **Structured Text (IEC 61131-3)** that controls a simplified welding cell as a **step chain** (state machine). Runs on the CODESYS Control Win V3 soft PLC.

![Running program](Screenshot%202026-10-30%20140932.png)

## Sequence

| Step | State   | Action                              | Time |
|------|---------|-------------------------------------|------|
| 0    | Idle    | Wait for start signal               | –    |
| 10   | Clamp   | Close clamp                         | 1 s  |
| 20   | Weld    | Welding current on                  | 3 s  |
| 30   | Cool    | Wait for part to cool               | 2 s  |
| 40   | Release | Open clamp, count part, back to 0   | –    |

Steps are numbered in tens so new steps can be inserted later without renumbering.

## How it works
- `nStep` holds the current state; a `CASE` statement runs only the logic of the active step.
- One `TON` timer handles the timing of each step and is reset on every transition.
- Outputs (`bClamp`, `bWeld`) keep their value until a later step changes them.
- `nParts` counts finished parts.

## Tools
CODESYS V3.5 SP22 · CODESYS Control Win V3 x64 (soft PLC)

## Roadmap
- [x] Basic step chain (Idle → Clamp → Weld → Cool → Release)
- [ ] Emergency stop and fault state
- [ ] Step timeout alarms and reset logic
- [ ] Energy counter per cycle
- [ ] CODESYS visualisation (HMI)

## Files
- `WeldCell.st` – program code as plain text
- `WeldCell.project` – full CODESYS project
