MySQL_table_define
====

Overview
- MySQLのテーブル定義・インデックス情報をMarkdown形式で出力します。

## Description
- 指定したデータベースにあるテーブル定義・インデックス情報を、Markdownのテーブルの形でファイルに出力します。
- テーブルの情報を取得する際には、下記コマンドを実行しています。
```
show full fields from テーブル名
show index from テーブル名
```
- ExcelやHTMLの形式でテーブル定義を出力するスクリプトはネット上に落ちてましたが、Markdownでの出力が見つからなかったので、自分でシェル書きました。
- 動作確認済みMySQLバージョン: 5.6.x
  - ほかのバージョンでは一切動作確認をしていないので、動作保証はありません。

## Requirement
- 依存関係はおそらくありません。

## Usage
1. desc_tables.shをサーバ上に保存します。
  - 必要に応じてシェルに対して実行権限を付与してください。
2. 下記のようにコマンドを実行します。  
  `$ ./desc_tables.sh DBホスト DBユーザ DBパスワード DB名`
3. シェルを置いた場所と同じディレクトリに「データベース名.md」でファイルが出力されます。

## Install
- スクリプトの内容のコピペか、このリポジトリのclone。

## Licence
- ライセンスは特にありません。ご自由に改良してください。

## Author
[moichi82](https://github.com/moichi82)
- まったくプロフィール書いてませんが…
