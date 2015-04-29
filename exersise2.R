#############################################
############# 演習2 : Rの基本操作 #############
#############################################

# 四則演算（数字）
1 + 1 # 足し算
3 - 1 # 引き算
6 * 2 # 掛け算
4 / 2 # 割り算
2^5 # 2の5乗
log10(5) # 5の常用対数値

# オブジェクトに格納
A <- 1 + 1 # オブジェクトに格納
A # オブジェクト名を打つと、値が画面に出力される（print(A)も同様）
A * 2 # (1 + 1) × 2を実行した事と同じ

# 値の型
try(1 + "1") # 数値と文字列を足すことはできない
paste0("ABCDE", "1") # 文字列同士を連結することはできる
paste0("ABCDE", 1) # paste0関数の仕様で、文字列と数値を連結することはできる

# 真偽
1 == 1 # これはTRUE（==は同じという意味）
1 == 2 # これはFALSE
"A" == "A" # これはTRUE
"A" == "B" # これはFALSE
"A" != "B" # これはTRUE（!=は違うという意味）
# TRUE/FALSEはif文と一緒に使うことが多い
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
C <- c("A", "B", "C", "A", "AA")
# Aがどこの場所にあるか
which(C == "A")
# lengthと組み合わせて使うことが多い
length(which(C == "A"))

######################### 因子 ##########################
# 同じものが複数
D <- factor(c("A", "A", "B", "B", "B"))
nlevels(D) # 2つある
levels(D) # A, Bがある

######################### 行列 ##########################
# matrix()で行列を作成
E <- matrix(runif(6), nrow=2, ncol=3)
E[1,]
E[,2]
# 行数、列数
nrow(E)
ncol(E)
dim(E)
# cbind、rbind
cbind(A, B)
rbind(E, A, B)
# 行レベルでの和、列レベルでの和・平均値
rowSums(E)
colSums(E)
rowMeans(E)
colMeans(E)

##################### データフレーム #####################
# 行列は一つの型しか扱えない
# 複数の型（数値、文字、TRUE/FALSE、因子など）を扱いたいときはデータフレーム
data(iris)
head(iris)
iris$Petal.Length # $で各列にアクセスできる

######################## リスト #########################
# もはや行列で表現できないようなデータもリストで表現できる
G <- list(X = c(1,2,3), Y = matrix(runif(9), nrow=3), Z = TRUE)
G$X # $で各要素にアクセスできる
G$Y
G$Z

############### Rオブジェクトに対してのあれこれ #############
is(iris)
str(iris)
str(G)
x <- runif(10)
y <- runif(10)
linear_reg <- lm(y ~ x)
str(linear_reg)
linear_reg$coefficients

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
H <- read.table("factor_test.tsv")
H[,1]
# strigsAsFactorsをFALSEとしておくことでfactor化を防ぐことができる
H <- read.table("factor_test.tsv", stringsAsFactors = FALSE)
H[,1]
