# Day 2 Walkthrough: Enemy & Combat Basics

We have successfully implemented the foundation of the combat system and the first enemy type.

## Achievements
### 1. New Actor: Spyder
- Created an intelligent chasing enemy with **separation logic** (Boids) to prevent stacking.
- **Telegraph System**: Approaches to 80px -> Stops & Flashes Red -> Lunges at high speed.
- **Physics**: Configured as `Floating` mode with specific Collision Layers to prevent "sticky" physics interaction with the Player.

### 2. Combat Mechanics
- **Robust Hit Detection**: Implemented `HitboxComponent` that toggles `CollisionShape2D` to ensure attacks register even at zero distance.
- **Hit Stop & Zoom**: Created `GameManager` to handle "Game Feel".
    - Damage causes a **0.15s Global Time Freeze**.
    - Camera instantly **Zooms In (10%)** during the freeze for impact.

## Verification
- [x] Enemies swarm but don't stack (Separation).
- [x] Attack cycle (Chase -> Warn -> Lunge) works clearly.
- [x] Player takes damage (DEBUG Log) reliably even when hugging the enemy.
- [-] Hit Stop and Camera Zoom: Implemented in GameManager, but disabled for *Player Damage* to enforce high-tempo flow (Per User Request).

## Next Step
**Day 3: Just Dodge (Risk & Return)**
We will now implement the core mechanic: dodging *into* these attacks to trigger slow motion.
