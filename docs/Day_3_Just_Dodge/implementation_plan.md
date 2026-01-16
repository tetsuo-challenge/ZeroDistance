# Implementation Plan - Day 3: Just Dodge & Risk/Return

## Goal
Implement the core "Risk and Return" loop: Enter Circle -> Wait for Attack -> Just Dodge -> Slow Motion -> Counter Rush.

## Proposed Changes
### 1. GameManager (Autoload)
- **Path**: `res://_src/Autoloads/GameManager.gd`
- **Responsibility**: Manages global time scale (Engine.time_scale).
- **Functions**:
    - `hit_stop(duration)`: For impact weight.
    - `activate_just_dodge()`: Sets time_scale to 0.1, creates visual flare.

### 2. Player Updates
- **Dodge Action**:
    - Input: SPACE (`dodges`).
    - Logic: When pressed, check all overlapping bodies in `KillCircle`.
    - **Condition**: If `body` is Enemy AND `body.is_attacking` == true...
- **Result**: Call `GameManager.activate_just_dodge()`. Enter `RUSH` state.

### 3. Enemy Updates
- **Attack State**:
    - Needs `is_attacking` boolean flag public for Player to check.
    - Needs `take_damage()` to react to the Counter Rush.

## Verification Plan
- **Test A (Timing)**: Stand in Circle. Wait for Red Flash. Press Space. Verify Time Slows down.
- **Test B (Counter)**: During Slow Mo, press Attack. Verify Enemy HP melts.
