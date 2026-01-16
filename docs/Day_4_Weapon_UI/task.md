# Task List: Day 4 - Weapon System & UI

- [x] **Main Weapon (Sword) Implementation**
    - [x] Create `WeaponComponent` (Composition).
    - [x] Implement `Standard Attack` (Left Click).
        - [x] Animation/Tween (Swing).
        - [x] Hitbox activation.
    - [x] Cooldown system.
    - [ ] Weapon Drops? (Moved to Day 5 / Postponed)

- [x] **Player Integration**
    - [x] Integrate Weapon into `Player.tscn`.
    - [x] Prevent attacking during Dash/Just Dodge states (State management).

- [x] **User Interface (HUD)**
    - [x] create `HUD.tscn`.
    - [x] **Health Bar**: Connect to `Player.HealthComponent`.
    - [x] **Kill Count**: Track enemies defeated.
    - [ ] **Kill Circle Indicator**: (Already exists on Player, decided not to add to HUD for minimal design)

- [x] **Game Loop Cycle**
    - [x] "Game Over" screen when HP triggers 0.
    - [x] Restart functionality.
