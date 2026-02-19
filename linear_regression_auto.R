library(MASS)
library(ISLR2)
fix(Auto)
#(a)
lm_fit=lm(mpg~horsepower,data=Auto)
summary(lm_fit)
#i)Q,説明変数と応答変数には関係があるのか？
#A,p値が十分に小さいため帰無仮説を棄却するため説明変数と応答変数には関係がある
#ii)Q,説明変数と応答変数の関係はどの程度強いか？
#A,決定係数の値が0.6でhorsepowerのばらつきの60％をmpgが説明でき、全体のp値が十分に小さいため非常に強いと考えられる
#iii)Q,説明変数と応答変数の関係は正の方向か負の方向か
#A,bのグラフにより負の関係
#iv)Q,housepowerが98の時予測されるmpgは何か？95%信頼区間と予測区間はどうなるか
#予測
predict(lm_fit,data.frame(horsepower=c(98)))
#信頼区間
predict(lm_fit,data.frame(horsepower=c(98)),interval = "confidence")
#予測区間
predict(lm_fit,data.frame(horsepower=c(98)),interval = "prediction")

#b,Q応答変数と説明変数のプロットを作成し、abline関数を使用して最小二乗回帰直線を表示
plot(Auto$horsepower,Auto$mpg)
abline(lm_fit)

#c,plot関数を使用して、最小二乗回帰の適合性を示す診断プロットを生成し、適合性に関する問題点についてコメント
plot(lm_fit)
#赤い線が線形ではなく、左側より右側の方が散らばりが狭く見えるためモデルが線形ではない点と分散が不均一であるところに問題がある

