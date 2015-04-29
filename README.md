# Level1_3_R
細胞工学別冊 次世代シーケンサー Dry解析超入門 Level1 [3] Rの使い方で利用したソースコード

gitコマンドでローカルマシンにダウンロードする事ができます。

```
git clone https://github.com/kokitsuyuzaki/Level1_3_R/
cd Level1_3_R
```

あとは、Rを起動したのちに、以下のようにコマンドをうつだけで、結果を再現する事ができます。

```
source("exersise1.R") # 演習1 : 準備
source("exersise2.R") # 演習2 : Rの基本操作
source("exersise3.R") # 演習3 : データの前処理
source("exersise4.R") # 演習4 : データ解析（PCA）
source("exersise5.R") # 演習5 : データの可視化（plot3d）
source("plotly.R") # plotlyにより外れ値細胞のラベルを見つける
source("exersise4_2.R") # 演習4 : データ解析（PCA 2回目）
source("exersise5_2.R") # 演習5 :　データの可視化（plot3d 2回目）
```
