# Task List: Day 2 - Enemy & Combat Basics

- [x] **Enemy Foundation**
    - [x] Create `Enemy` Scene & Script structure.
    - [x] attach `HealthComponent`, `HurtboxComponent`, `HitboxComponent`.
- [x] **Enemy AI (Movement)**
    - [x] Implement "Seek Player" behavior (Velocity-based).
    - [x] Implement "Soft Collision" (Steering Separation) to prevent overlapping.
- [x] **Enemy AI (Aggression)**
    - [x] Implement State Machine (Idle -> Chase -> Telegraph -> Attack).
    - [x] Telegraph logic (Visual flash/Color change).
    - [x] Attack Active logic (Enable Hitbox).
- [x] **Combat Resolution**
    - [x] Verify Damage dealing (Hitbox -> Hurtbox).
    - [x] Implement "Hit Stop" verification (Frame freeze on hit).
