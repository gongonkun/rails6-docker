# 自分用のrails6作るやつ

1. `docker-compose build`

2. `docker-compose run --rm web rails new . --force --database=mysql`

3. database.yml 書き換え

4. `docker-compose up -d`

5. `docker-compose run --rm web rake db:create`
