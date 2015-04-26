#############################################
############## 演習4 : データ解析 #############
#############################################
# パッケージインストール（一度やればよい）
install.packages("kernlab")

# パッケージ読み込み
library("kernlab")

# データ読み込み
load("Count.Rdata")

# 主成分分析
pca_data <- scale(t(Count[, 3:ncol(Count)]), scale=TRUE) # 正規化（平均値0, 分散1にする）
pca <- prcomp(pca_data)
save(pca, file="pca.Rdata")

# カーネル主成分分析（ガウシアンカーネル）
kernelpca <- kpca(t(pca_data), kernel="rbfdot", kpar=list(sigma=0.0001), features=3)
save(kernelpca, file="kernelpca.Rdata")
