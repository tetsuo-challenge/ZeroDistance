# Implementation Plan - Project Initialization

## Goal
Initialize the "ZERO DISTANCE" game project based on the provided design and technical documents.

## Proposed Changes
### Game Mechanics Specifications (Confirmed)
- **Player Attack**:
    - Standard Attack: Always available but deals low damage.
    - Counter Attack: Activated during "Just Dodge" (Time Slow). Button mashing triggers rapid attacks (BotW Rush).
- **Kill Circle (Aura)**:
    - Always active around player (Player-centric).
    - **Function**: Defines the "Just Dodge" validity range. If an enemy attacks *inside* this circle and is dodged -> Just Dodge triggers.
    - **Clarification**: Enemies *can* attack from outside, but dodging those does NOT trigger the bonus. This forces players to stay close (Risk).
- **Enemy Design**:
    - Fewer count, tougher individual strength (not a swarm survivor).
    - Can attack anytime (not limited by Circle).
    - Drop weapons only on **Death**.
- **Weapon System**: Single weapon type (**Sword**). Auto-equip higher tier on pass-over.

### Directory Structure
- Create `res://_src/` folder structure as defined in `ルール`.

### Core Components
- `HealthComponent`: Node based, signals for death/health change.
- `Hitbox/Hurtbox`: Area2D based interactions.

## Verification Plan
- Manual check of folder structure.
- Unit testing or basic scene testing for components.
