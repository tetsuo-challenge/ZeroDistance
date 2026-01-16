# Implementation Plan - Day 2: Enemy & Combat

## Goal
Implement a functional Enemy that chases the player, avoids stacking with other enemies, and performs telegraphed attacks.

## Proposed Changes
### New Actor: Spyder (Enemy)
- **Scene**: `res://_src/Actors/Spyder.tscn`
- **Script**: `res://_src/Actors/Spyder.gd`
- **Components**:
    - `HealthComponent`: 30 HP.
    - `HurtboxComponent`: Body size.
    - `HitboxComponent`: Active only during Attack state.

### Enemy AI Logic
- **Physics**: `CharacterBody2D`.
- **Movement**:
    - `steer_seek()`: Accelerate towards Player.
    - `steer_separation()`: Push away from neighbors in `Enemy` group.
- **State Machine (Enum)**:
    - `CHASE`: Default. Move towards player.
    - `TELEGRAPH`: Stop moving. Flash Red. Wait 0.5s.
    - `ATTACK`: Dash forward or Pulse. Hitbox Active. Lasts 0.2s.
    - `COOLDOWN`: Wait 1.0s before chasing again.

### Game Manager
- Need a Global signal bus or Manager to handle "Hit Stop" later. For now, keep it local.

## Verification Plan
- **Movement**: Spawn 10 enemies. They should surround player but not merge into one dot.
- **Combat**: Enemy turns red -> attacks. Player takes damage (console log or HP reduction).
