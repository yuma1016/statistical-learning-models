library(MASS)　
library(ISLR2)
library(dplyr)
library(glmnet)
library(e1071)
#(a)Q mpgの中央値以上の値を含む場合に1を中央値未満の値を含む場合に0を含むバイナリ変数mpg01を作成する
med<-median(Auto$mpg)
med
Auto$mpg01<-ifelse(Auto$mpg>med,1,0)
print(Auto)
#(b)　Qデータをグラフで調査し、mpg01と他の特徴量との関連性を調べます。どの特徴量がmpg01の予測に最も役立ちそうか

#ステップワイズ法により最適なモデルを構築する
full_model <- glm(mpg01 ~ .-mpg-name, data = Auto, family = binomial)
#アルゴリズムが収束しないため、LASSO回帰により変数を選択

#LASSO回帰
x <- model.matrix(mpg01 ~ . - mpg - name,data = Auto)[,-1]
y <- Auto$mpg01
cv_fit <- cv.glmnet(x, y, alpha = 1)
coef(cv_fit, s = "lambda.min")
#LASSO回帰の結果から再度ステップワイズ法を行う
full_model <- glm(mpg01 ~ .-mpg-name-displacement, data = Auto, family = binomial)

best_model <- step(full_model, direction = "backward", trace = 0) 
summary(best_model)
#(c)Q データをトレーニングセットとテストセットに分割する
print(Auto$year)
#トレーニングセットを７０～８１年、テストセットを82年とする
train=(Auto$year<82)
Auto82=Auto[!train,]
mpg82=Auto$mpg01[!train]
#(d)　Qトレーニングデータを使用してmpg01を予測するためにLDAを実行する。(b)でmpg01と最も関連していると思われる変数を使用する。モデルのテスト誤差はどのくらいか？
LDA=lda(mpg01~horsepower+weight+year+origin,data=Auto,subset = train)
LDA
Prediction_LDA=predict(LDA,Auto82)
table(Prediction_LDA$class,mpg82)
seikai_l<-mean(Prediction_LDA$class==mpg82)
testgosa_l<-1-seikai_l
testgosa_l
#(e)Qトレーニングデータを使用してmpg01を予測するためにQDAを実行する。(b)でmpg01と最も関連していると思われる変数を使用する。モデルのテスト誤差はどのくらいか？
QDA=qda(mpg01~horsepower+weight+year+origin,data=Auto,subset = train)
QDA
Prediction_QDA=predict(QDA,Auto82)
table(Prediction_QDA$class,mpg82)
seikai_q<-mean(Prediction_QDA$class==mpg82)
testgosa_q<-1-seikai_q
testgosa_q
#(f)Qトレーニングデータを使用してmpg01を予測するためにロジスティック回帰を実行する。(b)でmpg01と最も関連していると思われる変数を使用する。モデルのテスト誤差はどのくらいか？
LR_train=glm(mpg01~horsepower+weight+year+origin,data=Auto,family = binomial,subset = train)
LR_train
Prediction_LR=predict(LR_train,Auto82,type="response")
n82=dim(Auto82)[1]
mpg82_predict=array(0,n82)
mpg82_predict[Prediction_LR>0.5]=1
table(mpg82_predict,mpg82)
seikai_LR<-mean(mpg82==mpg82_predict)
seikai_LR
testgosa_LR<-1-seikai_LR
testgosa_LR
#(g)Qトレーニングデータを使用してmpg01を予測するためにナイーブベイズを実行する。(b)でmpg01と最も関連していると思われる変数を使用する。モデルのテスト誤差はどのくらいか？
nb.fit=naiveBayes(mpg01~horsepower+weight+year+origin,data=Auto,subset = train)
nb.fit
nb.class<-predict(nb.fit,Auto82)
table(nb.class,mpg82)
seikai_nb<-mean(nb.class==mpg82)
testgosa_nb<-1-seikai_nb
testgosa_nb
