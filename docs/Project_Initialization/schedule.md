# ZERO DISTANCE - Development Schedule

This schedule outlines the path to completing the "ZERO DISTANCE" prototype, focusing on high-quality implementation of core mechanics.

---

## Day 1: Foundation & The Player
**Goal**: Establish the project structure and creating a responsive Player Controller.
- **Tasks**:
    - [ ] Project Setup: Create folder structure (`_src/Actors`, `Components`, etc.) per specific rules.
    - [ ] Component System: Implement `HealthComponent`, `HitboxComponent`, `HurtboxComponent`.
    - [ ] Player Controller:
        - [ ] Implement Snappy WASD Movement (high friction/acceleration).
        - [ ] Implement "Kill Circle" visual (Shader/Sprite) attached to Player.
    - [ ] Basic Scene: A dark arena testbed.

## Day 2: The Enemy & Combat Basics
**Goal**: Implement the Enemy AI and the fundamental damage loop.
- **Tasks**:
    - [ ] Enemy AI (Movement):
        - [ ] Implement "Seek Player" behavior.
        - [ ] Implement "Soft Collision" (Steering Separation) for smooth crowded movement.
    - [ ] Enemy AI (Aggression):
        - [ ] State Machine: Idle -> Chase -> Attack Telegraph -> Attack Active.
    - [ ] Hit Detection:
        - [ ] Verify Hitbox -> Hurtbox damage dealing (Simple HP reduction).
        - [ ] Implement "Hit Stop" (frame freeze) on damage.

## Day 3: The Core Mechanic (Just Dodge)
**Goal**: Implement the "Risk and Return" system. The most critical day.
- **Tasks**:
    - [ ] Just Dodge Detector:
        - [ ] Logic: Check `Enemy.is_attacking` + `Player.is_in_kill_circle` + `Player.pressed_dodge`.
    - [ ] Global Time Control:
        - [ ] Implement `GameManager.slow_motion()` (TimeScale manipulation).
    - [ ] Counter Attack (The Rush):
        - [ ] Player State: Switch to "Rush Mode" during Slow Motion.
        - [ ] Input: Rapid clicks trigger rapid attack animations/damage.

## Day 4: Progression & Game Loop
**Goal**: Implement the weapon dropping and upgrading system.
- **Tasks**:
    - [ ] Weapon Resource System: Define `WeaponData` (Tier, Damage, Sprite).
    - [ ] Drop System: Enemies spawn a `WeaponPickup` on death.
    - [ ] Auto-Loot Logic:
        - [ ] Player collision with Pickup check -> Compare Tier -> Auto Equip.
    - [ ] HUD: Minimize UI. Show current Health and Weapon Tier only.

## Day 5: Polish & Juice (The "Sakurai" Touch)
**Goal**: Visual feedback, sound, and tuning.
- **Tasks**:
    - [ ] Visuals:
        - [ ] Screenshake on impacts.
        - [ ] Flash effects for Just Dodge.
        - [ ] Post-processing (Glow/Bloom) for the Neon look.
    - [ ] Tuning:
        - [ ] Adjust Telegraph time (0.5s) and Active Frame (0.2s) for fairness.
        - [ ] Tweaking movement friction for perfect control.

---
**Note**: We will proceed day by day. Confirmation will be requested after each day's completion.
