# Day 3 Walkthrough: Just Dodge & Counter Rush

We have implemented the core "Risk & Return" mechanics that define *ZERO DISTANCE*.

## Mechanics
### 1. Just Dodge (Risk)
- **Trigger**: Pressing `Space` while inside the Kill Circle of an ATTACKING enemy.
- **Effect**: Successfully evading triggers **Slow Motion (Time Scale 0.1)** for 3 seconds.
- **Feedback**: 
    - **Flashbang**: Screen flashes white instantly.
    - **Distortion**: Chromatic Aberration intensifies, warping the visuals.

### 2. Counter Rush (Return)
- **Trigger**: Pressing `Space` *during* Slow Motion.
- **Effect**: Instantly **annihilates** all enemies within the Kill Circle (Radius 150px).
- **Feedback**: Enemy vanishes immediately upon input. logic handles signal connection to ensure clean deletion.

## Technical Enhancements
- **GameManager**: Now handles global time scale, screen flash generation, and environment tweening.
- **WorldEnvironment**: Added to Sandbox for Glow and Distortion effects.
- **Input Handling**: strict state checks in `Player.gd` prevent spamming; only valid risks yield rewards.

## Verification
- [x] Just Dodge triggers Slow Mo + Flash + Distortion.
- [x] Counter Rush deletes enemies instantly.
- [x] Visuals return to normal after Slow Mo ends.

## Next Step
**Day 4: Weapon System & UI**
We will implement the "Main Weapon" for standard combat and the HUD to visualize Hell/Heaven Gauge (if applicable) or Score.
