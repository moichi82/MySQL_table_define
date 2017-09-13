#!/bin/bash

IFS='
'

HOST=${1}
USER=${2}
PASSWORD=${3}
DB=${4}

if [ $# -ge 5 ]; then
  PORT=${5}
else
  PORT=3306
fi

if [ $# -ge 6 ]; then
  OUT=${6}
else
  OUT="./${DB}.md"
fi

exec 1> >(cat > $OUT)

echo "# ${DB}"
for table in `MYSQL_PWD=${PASSWORD} mysql -h${HOST} -u${USER} -P ${PORT} -e "show tables;" -N ${DB}`
do
  echo "## ${table}"

  # テーブル定義の出力
  echo '### Fields'
  echo '| Field | Type | Collation | Null | Key | Default | Extra | Comment |'
  echo '| --- | --- | --- | --- | --- | --- | --- | --- |'

  for line in `MYSQL_PWD=${PASSWORD} mysql -h${HOST} -u${USER} -P ${PORT} -e "show full fields from ${table}" -N ${DB}`
  do
    field=`echo ${line} | cut -f1`
    type=`echo ${line} | cut -f2`
    collation=`echo ${line} | cut -f3`
    null=`echo ${line} | cut -f4`
    key=`echo ${line} | cut -f5`
    default=`echo ${line} | cut -f6`
    extra=`echo ${line} | cut -f7`
    comment=`echo ${line} | cut -f9`

    echo "| ${field} | ${type} | ${collation} | ${null} | ${key} | ${default} | ${extra} | ${comment} |"
  done

  # インデックス情報の出力
  echo '### Indexs'
  echo '| Non_unique | Key_name | Seq_in_index | Column_name | Sub_part | Packed | Index_type | Comment | Index_comment |'
  echo '| --- | --- | --- | --- | --- | --- | --- | --- | --- |'

  for line in `MYSQL_PWD=${PASSWORD} mysql -h${HOST} -u${USER} -P ${PORT} -e "show index from ${table}" -N ${DB}`
  do
    non_unique=`echo ${line} | cut -f2`
    key_name=`echo ${line} | cut -f3`
    seq_in_index=`echo ${line} | cut -f4`
    column_name=`echo ${line} | cut -f5`
    sub_part=`echo ${line} | cut -f8`
    packed=`echo ${line} | cut -f9`
    index_type=`echo ${line} | cut -f11`
    comment=`echo ${line} | cut -f12`
    index_comment=`echo ${line} | cut -f13`

    echo "| ${non_unique} | ${key_name} | ${seq_in_index} | ${column_name} | ${sub_part} | ${packed} | ${index_type} | ${comment} | ${index_comment} |"
  done

  echo
done

exit 0
