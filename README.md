# docker-template
## 概要
* `docker-compose up --build -d` とするだけで、Jupyter を用いる分析環境ができる。


## 使い方
### JupyterLab を使う場合
* 使用するディレクトリにてレポジトリを clone。

```
$ git clone https://github.com/rkmtlab/docker-template.git
$ cd docker-template
```
* `docker-compose.yml` のサーバーに開けるポート番号を変更。
* `docker-compose up --build -d` とコマンドを打ち込む -> 分析環境のコンテナができる。

* docker の中に入る。 `docker exec -it (container名) bash`
* `/root/` にあるstart.sh を`/workspace/`に持ってきて、jupyter server を立ち上げる。
```
$ cp /root/start.sh ./
$ . start.sh
```

* local PC のブラウザの検索欄に、 `http://(サーバーのIPアドレス）:(開けたサーバーのポート）` と打ち込むと JupyterLab が立ち上がる。
  * 例： `https://172.244.9.33:2987`


### VSCode を使う場合
#### コンテナの作成
* 使用するディレクトリにてレポジトリを clone し、`dev/use-github` ブランチに移動。

```
$ git clone https://github.com/rkmtlab/docker-template.git
$ cd docker-template
$ git checkout dev/use-github
```

* `docker-compose.yml` と `Dockerfile`の中身を変更。
  * `docker-compose.yml` のサーバーに開けるポート番号 と `Dockerfile`のgithub アカウント名。
* `docker-compose up --build -d` とコマンドを打ち込む -> 分析環境のコンテナができる。

#### VSCode の設定
* vscodeでRemote Explore という拡張機能を入れる。
  * ![image](https://user-images.githubusercontent.com/64390823/209894093-3fcbb271-33b2-4bf4-896f-1826f282cb71.png)



* `ssh` の右にある `+` をクリック。
* 出てきた窓に `ssh root@(IP address) -p (docker-compose で設定した、リモート接続先に開けたポート番号) -i (github の秘密鍵へのPATH) ` と入力する。
* 出てくる「 `~/.ssh/config` を開く」のボタンを押す。

* `Host (IPアドレス）` となっているところの `(IPアドレス）`を好きな名前に変える。
  * (`dvorak`など。`a` でも `b` でもOK。入るときに使う名前なので何でもいい。)
* `REMOTE` の右側の更新ボタンを押す。
  * 現れる、`（設定した名前）`の右側のボタンを押すと、VSCode で Jupyter が使える。

### コンテナの閉じ方
* `docker-compose down`


## 関連ページ
暦本研scrapbox
[VSCode を使って、Jupyter を使える docker container を作る。](https://scrapbox.io/rkmtlab/VSCode_%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6%E3%80%81Jupyter_%E3%82%92%E4%BD%BF%E3%81%88%E3%82%8B_docker_container_%E3%82%92%E4%BD%9C%E3%82%8B%E3%80%82)

