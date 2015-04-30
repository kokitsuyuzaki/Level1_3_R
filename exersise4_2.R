#############################################
############## 演習4 : データ解析 #############
#############################################
# データ読み込み
load("Count.Rdata")

# 主成分分析（14_1875を除く）
Count2 <- Count[setdiff(1:nrow(Count), which(Count$Well == "14_1875")),]
pca_data2 <- t(Count2[, 3:ncol(Count2)])
pca2 <- prcomp(pca_data2, scale=TRUE)

# データ保存
save(Count2, file="Count2.Rdata")
save(pca2, file="pca2.Rdata")
