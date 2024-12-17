# docker-template

## 概要

- `docker compose up --build -d` とするだけで、Jupyter を用いる分析環境ができる。

## 使い方

### JupyterLab を使う場合

- 使用するディレクトリにてレポジトリを clone。

```
$ git clone https://github.com/rkmtlab/docker-template.git
$ cd docker-template
```

- `PORT={任意のポート番号} WORKSPACE={/workspaceにマウントしたいディレクトリ} docker compose up --build -d` とコマンドを打ち込む -> 分析環境のコンテナができ上がり、指定した Post 番号で JupyterLab が立ち上がる。

- docker の中に入る。 `docker exec -it (container名) bash`
- `/root/` にある start.sh を`/workspace/`に持ってきて、jupyter server を立ち上げる。

```
$ cp /root/start.sh ./
$ . start.sh
```

- local PC のブラウザの検索欄に、 `http://(サーバーのIPアドレス）:(開けたサーバーのポート）` と打ち込むと JupyterLab が立ち上がる。
  - 例： `https://172.244.9.33:2987`

### VSCode を使う場合 → `dev/use-github`  ブランチへ。
- 使用するディレクトリにてレポジトリを clone し、`dev/use-github` ブランチに移動。
- `dev/use-github` の README.md にあるやり方で作成する。

### コンテナの閉じ方

- `docker compose down`

### Tips

`-p` で Project Name をつけることを推奨。誰のものかわからなくなるので

```bash
$ docker compose -p up (Project Name) --build -d
```

## 関連ページ

暦本研 scrapbox
[VSCode を使って、Jupyter を使える docker container を作る。](https://scrapbox.io/rkmtlab/VSCode_%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6%E3%80%81Jupyter_%E3%82%92%E4%BD%BF%E3%81%88%E3%82%8B_docker_container_%E3%82%92%E4%BD%9C%E3%82%8B%E3%80%82)
