# Walkthrough: Day 4 - Weapon System & UI

## 実装内容
基本戦闘システムとゲームサイクル（UI、スコア、ゲームオーバー）を実装しました。

### 1. Weapon System (Sword)
- **Component**: `WeaponComponent.gd` を作成。攻撃ロジック、ヒットボックス制御、アニメーションをカプセル化しました。
- **Player**: 左クリック (`attack` アクション) で剣を振る機能を追加。
    - **Visual**: プレイヤーの前方に扇状の攻撃範囲を表示。
    - **Limit**: クールダウン (0.4s) と状態制限 (スローモーション中は攻撃不可) を設定。

### 2. User Interface (HUD)
- **Scene**: `HUD.tscn` を作成し、`Sandbox.tscn` に配置。
- **Health Bar**: プレイヤーの `HealthComponent` と連動し、ダメージを受けると減少。
- **Kill Count**: `GameManager` 経由で敵討伐数を追跡し、画面右上に表示。

### 3. Game Cycle
- **Score**: 敵 (`Spyder`) を倒すとスコア (+1) が加算。
- **Game Over**: プレイヤーのHPが0になると `GameManager` がゲームオーバー処理を実行。
    - コンソールに最終スコア表示。
    - 2秒後にシーンをリロード (リスタート)。

## Verification Results
- [x] **Combat**: 左クリックで剣を振り、敵にダメージを与えて倒せることを確認。
- [x] **UI**: HPバーの減少とキル数の更新を確認。
- [x] **Cycle**: プレイヤー死亡時にリスタートすることを確認。

## Next Step
**Day 5: Polish & Juice**
Day 4 までで「ゲームとして遊べる」状態になりました。次は「気持ちよさ」を追求します。
- ヒット時のスクリーンシェイク
- Just Dodge の演出強化
- 全体的なパラメータ調整
