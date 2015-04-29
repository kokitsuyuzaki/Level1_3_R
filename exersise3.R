#############################################
############ 演習3 : データの前処理 ############
#############################################

# データをとってくる
download.file("http://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE54006&format=file&file=GSE54006%5Fumitab%2Etxt%2Egz", destfile="Count.txt.gz") # 発現量データ
download.file("http://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE54006&format=file&file=GSE54006%5Fexperimental%5Fdesign%2Etxt%2Egz", destfile="ExpDesign.txt.gz") # 実験情報データ

# ファイルを解凍する
install.packages("R.utils") # パッケージインストール（一度やればよい）
library("R.utils") # パッケージ読み込み
try(gunzip("Count.txt.gz"))
try(gunzip("ExpDesign.txt.gz"))

# データを読み込む
Count <- read.table("Count.txt", row.names=1, header=TRUE, sep="\t")
ExpDesign <- read.table("ExpDesign.txt", row.names=1, header=TRUE, sep="\t", skip=6)

# どのくらいのサイズの行列か見てみる
dim(Count) # 20190 × 4590
dim(ExpDesign) # 4598 × 14

# 上の行だけ見て、内容を推測する
head(Count)
head(ExpDesign)


################### Count ###################
which(colSums(Count) == 0) # 90個、発現量0のウェルがある
ncol(Count) # 4590ウェル
Count <- Count[, which(colSums(Count) != 0)] # ゼロ細胞を取り除く
ncol(Count) # 4500ウェルまで減る

# IDが書かれた列を追加する
Count <- t(Count)
# 列名をWellにする
Count <- data.frame(Count, Well=sub("X", "", rownames(Count)))



################# ExpDesign #################
# 列名をWellにする
colnames(ExpDesign)[14] <- "Well"

levels(ExpDesign$group_name) # Cell typeに関する情報が、group_name列に記述されている
which(ExpDesign$group_name == "B cell") # B cell (CD19+/B220+) : 48細胞
which(ExpDesign$group_name == "CD8+pDC") # pCD (CD11c+/CD8a+/PDCA-1+) : 96細胞
which(ExpDesign$group_name == "monocyte_or_neutrophil") # Monocyte (Gr-1+/CD11b+) : 48細胞
which(ExpDesign$group_name == "NK_cell") # NK (NK-1.1+) : 48細胞

# 4種類の細胞のデータだけを取り出す
ExpDesign <- rbind(
  ExpDesign[which(ExpDesign$group_name == "B cell"), ],
  ExpDesign[which(ExpDesign$group_name == "CD8+pDC"), ],
  ExpDesign[which(ExpDesign$group_name == "monocyte_or_neutrophil"), ],
  ExpDesign[which(ExpDesign$group_name == "NK_cell"), ]
  )
# 48 + 96 + 48 + 48 = 240になってる
nrow(ExpDesign)
# 1細胞のみ入っているものだけ取り出す
sort(unique(ExpDesign$number_of_cells))
ExpDesign <- ExpDesign[which(ExpDesign$number_of_cells == "1"), ]
# 1細胞だけである事を確認
sort(unique(ExpDesign$number_of_cells))
# 237に減る
nrow(ExpDesign)
# 必要なデータだけ、取り出す
ExpDesign <- ExpDesign[, c(11,14)]


############## ExpDesignとCount #############
# ExpDesignとCountをマージする
Count <- merge(ExpDesign, Count, by="Well")
# 保存する
save(Count, file="Count.Rdata")
