# Task List: Day 4 - Weapon System & UI

- [ ] **Main Weapon (Sword) Implementation**
    - [ ] Create `WeaponComponent` (Composition).
    - [ ] Implement `Standard Attack` (Left Click).
        - [ ] Animation/Tween (Swing).
        - [ ] Hitbox activation.
    - [ ] Cooldown system.
    - [ ] Weapon Drops? (Maybe Day 5)

- [ ] **Player Integration**
    - [ ] Integrate Weapon into `Player.tscn`.
    - [ ] Prevent attacking during Dash/Just Dodge states (State management).

- [ ] **User Interface (HUD)**
    - [ ] create `HUD.tscn`.
    - [ ] **Health Bar**: Connect to `Player.HealthComponent`.
    - [ ] **Kill Count**: Track enemies defeated.
    - [ ] **Kill Circle Indicator**: (Already exists on Player, maybe enhance?)

- [ ] **Game Loop Cycle**
    - [ ] "Game Over" screen when HP triggers 0.
    - [ ] Restart functionality.
