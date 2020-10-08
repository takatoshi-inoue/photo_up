# 本アプリ(photo_up)を閲覧いただき誠にありがとうございます！
![dc621f0814d769da779a5f0ca63b80f9](https://github.com/takatoshi-inoue/photo_up/blob/master/dc621f0814d769da779a5f0ca63b80f9.jpg)
## ●アプリケーションの概要
#### このアプリは画像を投稿し、投稿した画像に対してコメントでコミュニケーションを取ることが出来ます。

## ●アプリケーションの機能一覧
#### 1.ログイン機能:  マイページで自分の投稿した画像の管理ができます。また他のユーザーのマイページも閲覧可能です。

#### 2.検索機能:  投稿されている画像のタイトルを検索できます。

#### 3.画像投稿機能:  世界中のユーザーと共有したい画像の投稿が可能です。

#### 4.編集機能:  投稿する画像を間違えた、やっぱりタイトルを変えたい時などにに変更できる仕様になってます。
#### （編集できるのは自分のデータのみです。他人のデータを編集することはできません）

#### 5.削除機能:  必要なくなった画像を削除できる機能です。
#### （削除できるのは自分のデータのみです。他人のデータを削除することはできません。）

#### 6.コメント機能:  非同期になっていますのでチャットとしてリアルタイムで対話が可能です。
#### （コメントをするにはユーザー登録が必須です）

## ●アプリケーション内で使用している記述一覧
#### 使用している言語: HTML,CSS,Ruby,JavaScript
#### デプロイ: AWSのEC2サーバ
#### webサーバ: Nginx
#### アプリケーションサーバ: Unicorn
#### データベースサーバ: MySQL
　　



## ● photo_up DB設計

# usersテーブル
|column|type|Option|
|------|----|------|
|email|string|null: false|
|encrypted_password|string|null: false|
|reset_password_token|string||
### Association
- has_many :tweets
- has_many :comments


# tweetsテーブル
|column|type|Option|
|------|----|------|
|name|string||
|text|string||
|image|string||
### Association
- belongs_to :users
- has_many :comments


# commentsテーブル
|column|type|Option|
|------|----|------|
|text|text||
|user_id|integer||
|tweet_id|integer||
### Association
- belongs_to :users
- belongs_to :tweets
