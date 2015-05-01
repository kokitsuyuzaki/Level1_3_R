#############################################
############ 演習5 : データの可視化 ############
#############################################
# パッケージ読み込み
library("rgl")

# データ読み込み
load("Count2.Rdata")
load("pca2.Rdata")

# 主成分寄与率（14_1875除去後）
png(file="Contribution_PCA2.png")
plot(pca2$sdev/sum(pca2$sdev), xlab="Principal Components", ylab="Proportion  of Variance", main="Contribution rate of the Principal Component")
dev.off()

# バイプロット
png(file="Biplot_PCA2.png")
biplot(pca2)
dev.off()

# 細胞をソートする際の表面マーカーで色を付ける
Label2 <- data.frame(group_name=Count2$group_name, Well=Count2$Well, Color=NA)

# B cell => オレンジ
Label2$Color[which(Label2$group_name == "B cell")] <- rgb(1, 0.25, 0, 0.5)
# NK T cell => 紫
Label2$Color[which(Label2$group_name == "NK_cell")] <- rgb(0.75, 0, 1, 0.5)
# pDC => 青
Label2$Color[which(Label2$group_name == "CD8+pDC")] <- rgb(0, 0, 1, 0.5)
# Monocyte => 黒
Label2$Color[which(Label2$group_name == "monocyte_or_neutrophil")] <- rgb(0, 0, 0, 0.5)

# 主成分分析
plot3d(pca2$rotation[, 1:3], xlab="PC1", ylab="PC2", zlab="PC3", col=Label2$Color)
writeWebGL(dir="PCA_3d_2", width=500)
