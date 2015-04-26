#############################################
############ 演習5 : データの可視化 ############
#############################################
# パッケージインストール（一度やればよい）
install.packages("kernlab")
install.packages("rgl")

# パッケージ読み込み
library("kernlab")
library("rgl")

# データ読み込み
load("Count.Rdata")
load("pca.Rdata")
load("kernelpca.Rdata")

# 主成分寄与率
plot(pca$sdev/sum(pca$sdev), xlab="Principal Components", ylab="Proportion  of Variance", main="Contribution rate of the Principal Component")

# 第1〜3主成分を使って3次元プロット
# 細胞をソートする際の表面マーカーで色を付ける
# 色を作る
# Color列を追加
Label <- data.frame(group_name=Count$group_name, Well=Count$Well, Color=NA)
# Class I : オレンジ, B cell
Label$Color[which(Label$group_name == "B cell")] <- rgb(1, 0.25, 0, 0.5)
# Class III : 紫, NK T cell
Label$Color[which(Label$group_name == "NK_cell")] <- rgb(0.75, 0, 1, 0.5)
# Class V : 青, pDC
Label$Color[which(Label$group_name == "CD8+pDC")] <- rgb(0, 0, 1, 0.5)
# Class VII : 黒, Monocyte
Label$Color[which(Label$group_name == "monocyte_or_neutrophil")] <- rgb(0, 0, 0, 0.5)

# 主成分分析
plot3d(pca$rotation[, 1:3], xlab="PC1", ylab="PC2", zlab="PC3", col=Label$Color)
writeWebGL(dir="PCA_3d", width=500)

# カーネル主成分分析（ガウスカーネル）
plot3d(cbind(pcv(kernelpca)[,1], pcv(kernelpca)[,2], pcv(kernelpca)[,3]), xlab="PC1", ylab="PC2", zlab="PC3", col=Label$Color)
writeWebGL(dir="KernelPCA_Gaussian_3d", width=500)

# plotly
source("plotly.R")
