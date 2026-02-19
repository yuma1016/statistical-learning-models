# Statistical Learning Basics in R

## 概要 (Overview)
このリポジトリは、データサイエンスの基礎固めとして、統計的学習の主要なアルゴリズムをRで実装・比較した学習記録（授業演習のアーカイブ）です。
流行りの機械学習ライブラリを使うだけでなく、背後にある数理モデル（変数選択や判別分析の特性）の挙動を基礎から理解することを目的に作成しました。
## 実装したアルゴリズム (Implemented Algorithms)
以下の手法を用いて、基礎的な分類・回帰タスクを実装しています。

* **変数選択・正則化**:
  * Stepwise Regression (ステップワイズ法)
  * LASSO Regression (L1正則化)
* **分類モデル (Classification)**:
  * Logistic Regression (ロジスティック回帰)
  * Linear Discriminant Analysis: LDA (線形判別分析)
  * Quadratic Discriminant Analysis: QDA (二次判別分析)
  * Naive Bayes (ナイーブベイズ)

## 使用技術とデータセット
* **言語**: R
* **パッケージ**: `MASS`, `ISLR2`, `glmnet`, `e1071`, `dplyr`
* **データ**: ISLRパッケージに同梱されている標準データセット（`Auto`, `Boston`）を使用し、アルゴリズムの比較評価に焦点を当てています。
