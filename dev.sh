#!/bin/bash

# コマンドライン引数から条件を取得
condition="$1"
sub_condition="$2"

# helpを作成
function usage {
  cat <<EOM
Usage: $(basename "$0") [OPTION|VALUE]...
  -h          ヘルプの表示
  up          docker compose up
  up-d        docker compose up -d
  down        docker compose down
  start       docker compose start
  stop        docker compose stop
  restart     docker compose restart
  app         docker compose app bash
  app XXX     docker compose app containerName bash
  db          docker compose exec db bash
  ps          docker compose ps
  logs        docker compose logs
  logs XXX    docker compose logs containerName
EOM

  exit 2
}

# 条件がない場合
if [ -z "$condition" ]; then
    echo "実行するコマンドを指定して下さい。"
    usage
    exit 1
fi

# 条件がある場合
if [ "$condition" = "up" ]; then
    echo "docker compose up"
    docker compose up
elif [ "$condition" = "up-d" ]; then
    echo "docker compose up -d"
    docker compose up -d
elif [ "$condition" = "down" ]; then
    echo "docker compose down"
    docker compose down
elif [ "$condition" = "start" ]; then
    echo "docker compose start"
    docker compose start
elif [ "$condition" = "stop" ]; then
    echo "docker compose stop"
    docker compose stop
elif [ "$condition" = "restart" ]; then
    if [ -n "$sub_condition" ]; then
        echo "docker compose restart $sub_condition"
        docker compose restart $sub_condition
    else
        echo "docker compose restart"
        docker compose restart
    fi
elif [ "$condition" = "app" ]; then
    if [ -n "$sub_condition" ]; then
      echo "docker compose exec $sub_condition bash"
      docker compose exec $sub_condition bash
elif [ "$condition" = "db" ]; then
    echo "docker compose exec db bash"
    docker compose exec db sh -c "mysql -utest -ptest"
elif [ "$condition" = "ps" ]; then
    echo "docker compose ps"
    docker compose ps
elif [ "$condition" = "logs" ]; then
    if [ -n "$sub_condition" ]; then
        echo "docker compose logs $sub_condition"
        docker compose logs $sub_condition
    else
        echo "docker compose logs"
        docker compose logs
    fi
else
    # どの条件にも合致しない場合のコマンド
    echo "使い方"
    usage
fi

# 引数別の処理定義
while getopts ":h" optKey; do
  case "$optKey" in
    '-h'|'--help'|* )
      usage
      ;;
  esac
done