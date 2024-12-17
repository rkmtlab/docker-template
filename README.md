# docker-template

## 概要

- `docker compose -p up (Project Name) --build -d` とするだけで、Jupyter を用いる分析環境ができる。

## 使い方
### VSCode を使う場合

#### コンテナの作成

- 使用するディレクトリにてレポジトリを clone し、`dev/use-github` ブランチに移動。

```
git clone https://github.com/rkmtlab/docker-template.git
mv docker-template (Project Name)  # docker-template/ フォルダの名前を、自分のプロジェクト名に変更する。
cd (Project Name)
git checkout dev/use-github
```

- `docker-compose.yml` と `Dockerfile` の中身を変更する。
  - `docker-compose.yml` のサーバーに開けるポート番号を設定する。
  - `Dockerfile`の github アカウント名を自らのアカウント名に変更する。
  - (optional) Dockerfile に記載している、使用する nvidia/cuda image の ubuntu・cuda の version を、使用する環境に合わせる。
    - 該当箇所： `FROM    nvidia/cuda:11.2.2-cudnn8-devel-ubuntu20.04`
    - ubuntu version の確認方法: `cat /etc/os-release`
    - cuda version  の確認方法: `cat /usr/local/cuda/version.txt` , `nvcc -V`
    - （参考）このレポジトリにある nvidia/cuda image の version は、 hgx の環境に合わせている。
      
- `docker compose -p (Container Name) up --build -d` とコマンドを打ち込む -> 分析環境のコンテナができる。
  - `-p` で `Container Name` をつけることを推奨。誰のものかわからなくなるので。

#### VSCode の設定

- vscode で Remote Explore という拡張機能を入れる。

  - ![image](https://user-images.githubusercontent.com/64390823/209894093-3fcbb271-33b2-4bf4-896f-1826f282cb71.png)

- `ssh` の右にある `+` をクリック。
- 出てきた窓に `ssh root@(IP address) -p (docker compose で設定した、リモート接続先に開けたポート番号) -i (github の秘密鍵へのPATH) ` と入力する。
- 出てくる「 `~/.ssh/config` を開く」のボタンを押す。

- `Host (IPアドレス）` となっているところの `(IPアドレス）`を好きな名前に変える。
  - (`dvorak`など。`a` でも `b` でも OK。入るときに使う名前なので何でもいい。)
- `REMOTE` の右側の更新ボタンを押す。
  - 現れる、`（設定した名前）`の右側のボタンを押すと、VSCode で Jupyter が使える。

### コンテナの閉じ方

- `docker compose down`


## 関連ページ

暦本研 scrapbox
[VSCode を使って、Jupyter を使える docker container を作る。](https://scrapbox.io/rkmtlab/VSCode_%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6%E3%80%81Jupyter_%E3%82%92%E4%BD%BF%E3%81%88%E3%82%8B_docker_container_%E3%82%92%E4%BD%9C%E3%82%8B%E3%80%82)
