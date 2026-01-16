# Walkthrough - Day 1: Foundation & Player

## Accomplished
- **Project Structure**: Created `_src/Actors`, `_src/Components` etc.
- **Core Components**: Implemented `HealthComponent.gd`, `HitboxComponent.gd`, `HurtboxComponent.gd`.
- **Player Logic**: Implemented `Player.gd` (Movement) and `KillCircleVisual.gd`.

## Manual Setup Required (Godot Editor)
Since I can only create scripts, please assemble the **Player Scene** in Godot:

1.  **Create New Scene**: CharacterBody2D.
2.  **Rename**: `Player`.
3.  **Attach Script**: Load `res://_src/Actors/Player.gd`.
4.  **Add Child Nodes**:
    -   `CollisionShape2D` (Circle, radius approx 20px).
    -   `Sprite2D` (Use `icon.svg` or a placeholder).
    -   `Node2D` (Rename to `KillCircleVisual`).
        -   Attach Script: `res://_src/Actors/KillCircleVisual.gd`.
    -   `Node` (Rename to `HealthComponent`).
        -   Attach Script: `res://_src/Components/HealthComponent.gd`.
    -   `Area2D` (Rename to `HurtboxComponent`).
        -   Attach Script: `res://_src/Components/HurtboxComponent.gd`.
        -   Add Child `CollisionShape2D` (Match player size).
        -   **Link**: In Inspector for `HurtboxComponent`, assign `HealthComponent` to the slot.
5.  **Save Scene**: `res://_src/Actors/Player.tscn`.

## Verification Steps
1.  Run the `Player.tscn` scene.
2.  **Movement**: Test arrow keys/WASD. It should feel quick to start and quick to stop ("Snappy").
3.  **Visuals**: Ensure the dark "Kill Circle" is drawn around the player.
