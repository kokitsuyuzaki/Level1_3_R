# Rの操作を簡単に説明する
# 四則演算（数字）
1 + 1 # 足し算
3 - 1 # 引き算
6 * 2 # 掛け算
4 / 2 # 割り算
# 値の型
# 文字（"や'でくくる）
"XYZ"
'XYZ' + 1 # 文字と数字は足し算できない
# 真偽
1 == 1 # これは真（==は同じという意味）
1 == 2 # これは偽
"A" == "A" # これは真
"A" == "B" # これは偽
"A" != "B" # これは真（!=はチガウという意味）
TRUE # 真、偽自体がオブジェクト
FALSE
(1 == 1) == TRUE
# ifで使うことが多い
X <- 1
Y <- 2
if(X == Y){
  print("同じ")
}else{
  print("違うよ！")
}

####################### ベクトル ########################
# c()でベクトルを作成
A <- c(2, 3, 1)
B <- c(-2, 1, -2)
# 最大値、最小値、平均値、中央値
max(A)
min(A)
mean(B)
median(B)
# 要素ごとの掛け算（他の言語と違うところ）
A * B
# ベクトル同士の内積
A %*% B
# 文字でもベクトル
D <- c("A", "B", "C", "A", "AA")
# Aがどこの場所にあるか
which(D == "A")
# lengthと組み合わせて使うことが多い
length(which(D == "A"))

######################### 因子 ##########################
# 同じものが複数
E <- factor(c("A", "A", "B", "B", "B"))
nlevels(E) # 2つある
levels(E) # A, Bがある

######################### 行列 ##########################
# matrix()で行列を作成
C <- matrix(runif(6), nrow=2, ncol=3)
# 行数、列数
nrow(C)
ncol(C)
dim(C)
# cbind、rbind
cbind(A, B)
rbind(C, A, B)
# 行レベルでの和、列レベルでの和・平均値
rowSums(C)
colSums(C)
rowMeans(C)
colMeans(C)

##################### データフレーム #####################
# 行列は一つの型しか扱えない
# 複数の型（数値、文字、TRUE/FALSE、因子など）を扱いたいときはデータフレーム
data(iris)
head(iris)
is(iris)
str(iris)
iris$Petal.Length # $で各列にアクセスできる

######################## リスト #########################
# もはや行列で表現できないようなデータもリストで表現できる
F <- list(X = c(1,2,3), Y = matrix(runif(9), nrow=3), Z = TRUE)
F$X # $で各要素にアクセスできる
F$Y
F$Z

################### データ保存・読み込み ##################
# 保存
# 基本的にTSVかCSVで保存しよう（セルを後で認識できるから）
write.table(iris, "iris.tsv", sep="\t")
write.table(iris, "iris.csv", sep=",")
# 画面に出力される文字をそのままファイルに保存しておきたいとき
sink("iris.txt")
iris
sink()
# Rのオブジェクトそのものを保存しておきたいとき
save(iris, file="iris.RData")

# 読み込み
iris1 <- read.table("iris.tsv", sep="\t")
iris2 <- read.table("iris.csv", sep=",")
# 今まで宣言してきたRオブジェクトを見てみる
ls()
# 一度消してみる
rm(iris)
ls()
load("iris.RData")
# 消したirisが復活している
ls()
# read.table時に文字がfactor化されてしまう（よくはまる箇所）
write.table(data.frame(moji = c("A", "B", "C", "D", "E"), suuji = runif(5)), "factor_test.tsv", sep="\t")
G <- read.table("factor_test.tsv")
G[,1]
# strigsAsFactorsをFALSEとしておくことでfactor化を防ぐことができる
G <- read.table("factor_test.tsv", stringsAsFactors = FALSE)
G[,1]
