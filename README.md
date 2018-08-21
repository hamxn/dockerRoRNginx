# LMP ONE

下記は本システムで使用している主なソフトウェア及びバージョンとなります。

* Ruby 2.5.0
* Rails 5.2.0
* ImageMagick 6.7.8-9
* Redis 3.2.11
* Yarn 1.7.0
* Nginx 1.12.1
* Node.js 6.14.3
* Unicorn 5.4.0

## MySQL
```
brew install mysql
bundle config --local build.mysql2 "--with-ldflags=-L/usr/local/opt/openssl/lib --with-cppflags=-I/usr/local/opt/openssl/include"
```

## Redis
```
brew install redis
redis-server /usr/local/etc/redis.conf
```

* Configuration

* Database creation

データーベースの設定はRailsの標準 `conf/database.yml` に集約されています。接続ユーザやパスワードを変更したい場合はこちらのファイルの設定を変更してください。

```
bin/rake db:setup
```

* Database initialization

## Active job 設定
redisを動かした状況で下記のコマンドを実行
```
bundle exec sidekiq -q default -q cron -q mailers
```

各キューの役割について
- `-q default`: `uploader` などの非同期で行いたいジョブが実行されます
- `-q mailers`: 非同期のメール送信が実行されます
- `-q cron`: `cron` として実行したいジョブが設定されます

## DDL 実行
```
bin/rake ridgepole:apply
```

## SQL表示
```
bin/rake ridgepole:apply_dry_run
```

## DB 定義を schemafile に出力
```
bin/rake ridgepole:export
```

## 動作検証用データ作成
```
bin/rake db:seed_fu
```

* How to run rails server

- 下記を実行
```
bundle install
bin/rails s
```

* How to run the test suite

```
bin/rspec spec/
```

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
- Deploy by CircleCI automatically

* Others

## Tips

- gem など使うときに migration ファイルが生成された場合

```
# まず migration 適用
bin/rails db:migrate

# ridgepole の schema ファイルに export
bin/rake ridgepole:export

# migration ファイル消す
rm db/migrate/* db/schema.rb
```

- pre-commit で rubocop 実行するようにする

```
bundle exec pre-commit enable git checks rubocop
```

## システム構成

システム構成については[こちら](./readme/infra.md "システム構成")を参照してください。
