# Implementation Plan: Day 5 - Polish & Juice

## Goal Description
Enhance the "Game Feel" by adding visual feedback, impact effects, and refining the "Neon" aesthetic. Transform the game from "functional" to "satisfying".

## Proposed Changes

### 1. Game Feel (Juice)
#### [NEW] `_src/Components/ShakeComponent.gd`
- A component to attach to Camera2D (or handle Camera shake globally).
- **Functions**: `shake(intensity, duration)`.
- **Logic**: Uses `FastNoiseLite` or `RandomNumberGenerator` to offset camera position.

#### [MODIFY] `_src/Actors/Player.tscn`
- Add `ShakeComponent` to the Camera2D.

#### [MODIFY] `_src/Components/WeaponComponent.gd`
- **Hit Stop**: Call `GameManager.hit_stop()` when `HitboxComponent` deals damage?
    - *Better approach*: Connect `Hitbox` signal? Or `Hurtbox` signal?
    - Let's have `Spyder.gd` (Hurtbox owner) trigger Hit Stop on damage.
- **Screen Shake**: Trigger shake on hit.

#### [MODIFY] `_src/Actors/Spyder.gd`
- **Hit Flash**: Tween `modulate` to White and back to Red/Normal on damage.
- **Particle**: Spawn a `CPUParticles2D` (Explosion) on death.

### 2. Visual Enhancements
#### [NEW] `_src/Effects/GhostTrail.gd` & Scene
- Spawns copies of Player sprite that fade out.
- **Integration**: `Player.gd` spawns these during `start_slow_motion` / `Rush Mode` movement.

#### [MODIFY] `_src/Levels/Sandbox.tscn`
- **WorldEnvironment**: Tweak Glow settings (Intensity 0.5 -> 1.2, Bloom 0.3).
- **Background**: Add a simple grid shader or texture for depth? (Optional, maybe keep it simple).

## Verification Plan
### Manual Verification
1.  **Hit Feedback**: Sword hit -> Screen shakes + Frame freeze + Enemy flashes white.
2.  **Death Feedback**: Enemy explodes into particles.
3.  **Dodge Feedback**: Just Dodge -> Screen Flash + Player leaves Ghost Trails.
