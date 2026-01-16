# Task List: Day 3 - The Core Mechanic (Just Dodge)

- [x] **Game Manager (Time Control)**
    - [x] Create `GameManager` autoload.
    - [x] Implement `start_slow_motion(duration, scale)` functionality.
    - [x] Implement `freeze_frame(duration)` for Hit Stop.
- [x] **Just Dodge Logic**
    - [x] Implement `Player.dodge()` action (invincibility frame).
    - [x] Implement "Kill Circle Check": Is Enemy attacking AND inside Circle?
    - [x] Trigger `GameManager.start_slow_motion()` on success.
- [x] **Counter Attack (Rush Mode)**
    - [x] Implement Player State `RUSH`.
    - [x] While in `RUSH` (during Slow Motion), attack button deals massive damage.
- [x] **Visual Feedback**
    - [x] Screen Flash on Just Dodge.
    - [x] Chromatic Aberration/Distortion (if possible) during slow mo.
