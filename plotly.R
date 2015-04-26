#️ パッケージインストール（一度やればよい）
install.packages("devtools")
devtools::install_github("ropensci/plotly")

# パッケージ読み込み
library("devtools")
# Learn about API authentication here: https://plot.ly/r/getting-started
# Find your api_key here: https://plot.ly/settings/api
library(plotly)

# データ読み込み
load("pca.Rdata")
load("kernelpca.Rdata")

# 
set_credentials_file("antiplastics", "t04mhock2b")
py <- plotly()

BCell <- list(
  x = as.numeric(pcv(kernelpca)[which(Label$group_name == "B cell"), 1]),
  y = as.numeric(pcv(kernelpca)[which(Label$group_name == "B cell"), 2]),
  z = as.numeric(pcv(kernelpca)[which(Label$group_name == "B cell"), 3]),
  mode = "markers+text",
  name = "B Cell",
  text = Label$Well[which(Label$group_name == "B cell")],
  textfont = list(
    color = "rgb(102, 102, 102)",
    size = 7),
  marker = list(
    size = 12,
    line = list(
      color = "rgba(217, 217, 217, 0.14)",
      width = 0.5
    ),
    opacity = 0.8
  ),
  type = "scatter3d"
)

NKTCell <- list(
  x = as.numeric(pcv(kernelpca)[which(Label$group_name == "NK_cell"), 1]),
  y = as.numeric(pcv(kernelpca)[which(Label$group_name == "NK_cell"), 2]),
  z = as.numeric(pcv(kernelpca)[which(Label$group_name == "NK_cell"), 3]),
  mode = "markers+text",
  name = "NKT Cell",
  text = Label$Well[which(Label$group_name == "NK_cell")],
  textfont = list(
    color = "rgb(102, 102, 102)",
    size = 7),
  marker = list(
    size = 12,
    line = list(
      color = "rgba(50, 217, 217, 0.14)",
      width = 0.5
    ),
    opacity = 0.8
  ),
  type = "scatter3d"
)

DC <- list(
  x = as.numeric(pcv(kernelpca)[which(Label$group_name == "CD8+pDC"), 1]),
  y = as.numeric(pcv(kernelpca)[which(Label$group_name == "CD8+pDC"), 2]),
  z = as.numeric(pcv(kernelpca)[which(Label$group_name == "CD8+pDC"), 3]),
  mode = "markers+text",
  name = "DC",
  text = Label$Well[which(Label$group_name == "CD8+pDC")],
  textfont = list(
    color = "rgb(102, 102, 102)",
    size = 7),
  marker = list(
    size = 12,
    line = list(
      color = "rgba(217, 50, 217, 0.14)",
      width = 0.5
    ),
    opacity = 0.8
  ),
  type = "scatter3d"
)

Monocyte <- list(
  x = as.numeric(pcv(kernelpca)[which(Label$group_name == "monocyte_or_neutrophil"), 1]),
  y = as.numeric(pcv(kernelpca)[which(Label$group_name == "monocyte_or_neutrophil"), 2]),
  z = as.numeric(pcv(kernelpca)[which(Label$group_name == "monocyte_or_neutrophil"), 3]),
  mode = "markers+text",
  name = "Monocyte",
  text = Label$Well[which(Label$group_name == "monocyte_or_neutrophil")],
  textfont = list(
    color = "rgb(102, 102, 102)",
    size = 7),
  marker = list(
    size = 12,
    line = list(
      color = "rgba(217, 217, 50, 0.14)",
      width = 0.5
    ),
    opacity = 0.8
  ),
  type = "scatter3d"
)

data <- list(BCell, NKTCell, DC, Monocyte)
layout <- list(
  scene = list(
    xaxis = list(
      title = "1st Component",
      gridcolor = "rgb(255, 255, 255)",
      showbackground = TRUE,
      spikecolor = "rgb(102, 102, 102)",
      backgroundcolor = "rgb(210, 210, 210)"
      ),
    yaxis = list(
      title = "2nd Component",
      gridcolor = "rgb(255, 255, 255)",
      showbackground = TRUE,
      spikecolor = "rgb(102, 102, 102)",
      backgroundcolor = "rgb(210, 210, 210)"
      ),
    zaxis = list(
      title = "3rd Component",
      gridcolor = "rgb(255, 255, 255)",
      showbackground = TRUE,
      spikecolor = "rgb(102, 102, 102)",
      backgroundcolor = "rgb(210, 210, 210)"
      )
    ),
  margin = list(
    l = 0,
    r = 0,
    b = 0,
    t = 0
    )
)

response <- py$plotly(data, kwargs=list(layout=layout, filename="MARS-Seq", fileopt="overwrite"))
url <- response$url
url
