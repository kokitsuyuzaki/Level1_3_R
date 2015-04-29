#############################################
############## 演習4 : データ解析 #############
#############################################
# データ読み込み
load("Count.Rdata")

# 主成分分析
pca_data <- scale(t(Count[, 3:ncol(Count)]), scale=TRUE) # 正規化（平均値0, 分散1にする）
pca <- prcomp(pca_data)

# データ保存
save(pca, file="pca.Rdata")
