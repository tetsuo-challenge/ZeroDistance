# Implementation Plan - Day 4: Weapon & UI

## Goal Description
Implement the core combat loop using a "Sword" weapon and provide necessary feedback via a User Interface (HUD). This moves the game from a movement prototype to a basic playable game loop.

## Proposed Changes

### 1. Weapon System
#### [NEW] `_src/Components/WeaponComponent.gd`
A generic component to handle weapon logic.
- **Properties**: `damage`, `cooldown_time`, `swing_speed`.
- **References**: `HitboxComponent` (for damage), `Sprite2D` (for visual).
- **Logic**:
    - `attack()`: Activates the hitbox, plays a tween animation (swing), and manages cooldown.
    - Signal `attack_started` / `attack_finished` for state management.

#### [MODIFY] `_src/Actors/Player.tscn` & `Player.gd`
Integrate the weapon.
- Add `WeaponComponent` node.
- Add `Sprite2D` for the sword (child of a pivot for rotation).
- Add `HitboxComponent` to the sword.
- **Input Handling**: Check for `attack` (Left Click).
- **State Prevention**:
    - CANNOT attack while `is_slow_motion` (Rush Mode takes precedence) or while dodging.
    - (Optional) CANNOT attack while already attacking (cooldown/animation lock).

### 2. User Interface (HUD)
#### [NEW] `_src/UI/HUD.tscn` & `HUD.gd`
- **Layout**:
    - Top Level `CanvasLayer`.
    - `HealthBar` (ProgressBar): Top Left.
    - `KillCount` (Label): Top Right.
- **Logic**:
    - Connect to `Player` signals (`health_changed`).
    - Connect to `GameManager` or `Player` signals (`score_updated`).

#### [MODIFY] `_src/Autoloads/GameManager.gd`
- Add `score` variable.
- Add `add_score(points)` function.
- Add `game_over()` logic (Simple scene reload for now).
- Add `player_died` signal handling.

#### [MODIFY] `_src/Levels/Sandbox.tscn`
- Instance `HUD.tscn`.
- Wire up dependencies if needed (though HUD usually finds Player/GameManager).

## Verification Plan
### Manual Verification
1.  **Combat Test**:
    - Left Click triggers sword swing.
    - Sword hitting Enemy triggers `Hitbox` -> `Hurtbox` logic (Enemy takes damage/dies).
    - Cannot attack while cooldown is active.
2.  **UI Test**:
    - Health Bar decreases when Player is hit by Enemy.
    - Kill Count increases when Enemy dies.
3.  **Game Cycle**:
    - Player death -> Restart (or Log message).
