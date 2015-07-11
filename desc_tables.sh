#!/bin/bash

IFS='
'

HOST=${1}
USER=${2}
PASSWORD=${3}
DB=${4}

exec 1> >(cat > "./${DB}.md")

echo '# '${DB}
for table in `MYSQL_PWD=${PASSWORD} mysql -h${HOST} -u${USER} -e "show tables;" -N ${DB}`
do
  echo '## '${table}

  # テーブル低ぢの出力
  echo 'Field | Type | Collation | Null | Key | Default | Extra | Comment'
  echo '--- | --- | --- | --- | --- | --- | --- | ---'

  for line in `MYSQL_PWD=${PASSWORD} mysql -h${1} -u${2} -e "show full fields from ${table}" -N ${4}`
  do
    field=`echo ${line} | cut -f1`
    type=`echo ${line} | cut -f2`
    collation=`echo ${line} | cut -f3`
    null=`echo ${line} | cut -f4`
    key=`echo ${line} | cut -f5`
    default=`echo ${line} | cut -f6`
    extra=`echo ${line} | cut -f7`
    comment=`echo ${line} | cut -f9`

    echo "${field} | ${type} | ${collation} | ${null} | ${key} | ${default} | ${extra} | ${comment}"
  done

  echo
done

exit 0

