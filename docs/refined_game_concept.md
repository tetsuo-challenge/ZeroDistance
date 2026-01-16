# ZERO DISTANCE - Refined Game Concept (The True Soul)

**"Enter the Dead Zone to Kill."**

This document records the finalized understanding of the game mechanics and philosophy, superseding initial interpretations.

---

## 1. The Core Philosophy: "Risk IS the Key"
The game does not force the player to take risks; it **rewards** them for it.
- **Enemies are dangerous**: They attack aggressively regardless of distance.
- **Safety is stagnant**: Dodging from afar ensures survival but grants no power.
- **Danger is power**: Only by stepping into the "Zero Distance" (the Kill Circle) does defense turn into offense.

## 2. Core Mechanics (The Loop)

### A. The Kill Circle (The License to Kill)
- **Visual**: A dark aura permanently attached to the Player. Fixed radius.
- **Function**: It defines the valid range for a **Just Dodge**.
- **The Rule**:
    - Enemy attacks OUTSIDE the circle -> Normal Dodge (No bonus).
    - Enemy attacks INSIDE the circle -> **Just Dodge Possible**.

### B. Just Dodge & Counter (The Payoff)
- **Trigger**: Pressing Dash at the perfect moment of an incoming attack **WHILE inside the Kill Circle**.
- **Effect**:
    - World enters **Global Slow Motion** (Time Freeze).
    - **Counter State**: The Player's weak standard attacks transform into a **High-Speed Rush** (Zelda: BotW style).
    - Input: Button mashing triggers the rush, dealing massive damage.

### C. Enemies (The Threat)
- **Quality over Quantity**: Not a horde survivor. Enemies are fewer but hit hard and have clear telegraphed attacks.
- **Aggression**: They do not wait. They will close distance and attack.
- **Separation**: They move smoothly around each other (Soft Collision physics), never overlapping but swarming intelligently.

### D. Progression (The Flow)
- **Weapon**: **Sword** only.
- **Improvement**: Weapons have specific "Tiers".
- **Acquisition**:
    - Weapons drop **only when an enemy dies**.
    - **Auto-Equip**: Moving over a higher-tier sword instantly equips it.
    - **No Menu**: The flow of combat never stops.

---

## 3. Technical Implementation Pillars
Derived from `ルール` and confirmed specs.

1.  **Architecture**: Component-based (Health, Hitbox, Hurtbox, Velocity).
2.  **Physics**: Area2D for detection, CharacterBody2D for movement, but using custom velocity logic for "snappiness".
3.  **Visuals**: High contrast. Dark background, Neon/Bright actors.
4.  **Feel**: Hit-stop on damage, Screen Shake on heavy impacts, Time Scale manipulation for Just Dodge.

---
**End of Refined Document.**
This file serves as the anchor for all future development decisions.
