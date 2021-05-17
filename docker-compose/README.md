# Docker Compose を利用した動作確認環境構築

- [Docker Compose](https://docs.docker.com/compose/)
- [PostgreSQLのDockerイメージ](https://hub.docker.com/_/postgres)

## 構成
- マシン 3 台想定。スーパーユーザとパスワードは `postgres` / `postgres` で共通。
- `postgresql.conf` / `pg_hba.conf` / `pg_ident.conf` 以外のファイルは必要に応じてコンテナ内へコピー

- dbhost1
  - 設定ファイル : `conf/dbhost1` 配下
- dbhost2
  - 設定ファイル : `conf/dbhost2` 配下
- dbhost3
  - 設定ファイル : `conf/dbhost3` 配下

### 設定ファイルのベース

```
mkdir -p $PWD/conf/sample

docker run \
  -i \
  --rm \
  -v $PWD/conf/sample:/sample \
  postgres:11 \
    bash -c "cp /usr/share/postgresql/11/*.sample /sample/"

sudo chown -R $(id -u):$(id -g) $PWD/conf/sample
```

## コンテナ操作

`docker-compose.yml` が存在するディレクトリ上で各種コマンドを実行する。

```
# 作成／起動
docker-compose up -d

# 起動
docker-compose start

# 停止
docker-compose stop

# 再起動
docker-compose restart

# 起動状態確認
docker-compose ps

# 削除
docker-compose down --volumes

# ログ確認
docker-compose logs
docker-compose logs dbhost1
```

```
# psql で接続 dbhost1 => dbhost1
docker-compose exec dbhost1 psql -U postgres

# psql で接続 dbhost2 => dbhost1
docker-compose exec dbhost2 psql -h dbhost1 -U postgres

# 起動したまま設定ファイルの変更反映
docker-compose exec dbhost1 psql -U postgres -c "SELECT pg_reload_conf();"

# bash 実行
docker-compose exec dbhost1 bash
```
