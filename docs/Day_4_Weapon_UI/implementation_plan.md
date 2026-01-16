# Implementation Plan - Day 4: Weapon & UI

## Goal
Implement the standard combat capability (Sword) and the user interface to visualize game state.

## Proposed Changes

### 1. Main Weapon (Sword)
**File**: `_src/Components/WeaponComponent.gd` [NEW]
- Basic sword logic:
    - Input: `attack` (Left Click).
    - Visual: `Sprite2D` rotation (Swing).
    - Logic: Activate `HitboxComponent` during swing.

**File**: `_src/Actors/Player.tscn`
- Add `WeaponComponent` and visual sprite.

### 2. User Interface (HUD)
**File**: `_src/UI/HUD.tscn` [NEW]
- `ProgressBar` for Health.
- `Label` for Kill Count (Score).
- `CanvasLayer` to overlay on screen.

**File**: `_src/Levels/Sandbox.tscn`
- Add `HUD` instance.

## Verification Plan
### Automated Tests
- None.

### Manual Verification
1.  **Weapon**: Left click swings weapon. Enemies die if hit.
2.  **HUD**: HP bar reduces when taking damage. Score increases when killing enemies.
