#############################################
############ 演習5 : データの可視化 ############
#############################################
# パッケージインストール（一度やればよい）
install.packages("rgl")

# パッケージ読み込み
library("rgl")

# データ読み込み
load("Count.Rdata")
load("pca.Rdata")

# 主成分寄与率
png(file="Contribution_PCA.png")
plot(pca$sdev/sum(pca$sdev), xlab="Principal Components", ylab="Proportion  of Variance", main="Contribution rate of the Principal Component")
dev.off()

# バイプロット
png(file="Biplot_PCA.png")
biplot(pca)
dev.off()

# 細胞をソートする際の表面マーカーで色を付ける
Label <- data.frame(group_name=Count$group_name, Well=Count$Well, Color=NA)
# B cell => オレンジ
Label$Color[which(Label$group_name == "B cell")] <- rgb(1, 0.25, 0, 0.5)
# NK T cell => 紫
Label$Color[which(Label$group_name == "NK_cell")] <- rgb(0.75, 0, 1, 0.5)
# pDC => 青
Label$Color[which(Label$group_name == "CD8+pDC")] <- rgb(0, 0, 1, 0.5)
# Monocyte => 黒
Label$Color[which(Label$group_name == "monocyte_or_neutrophil")] <- rgb(0, 0, 0, 0.5)

# 主成分分析
plot3d(pca$rotation[, 1:3], xlab="PC1", ylab="PC2", zlab="PC3", col=Label$Color)
writeWebGL(dir="PCA_3d", width=500)
