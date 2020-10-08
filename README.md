# 本アプリを閲覧いただき誠にありがとうございます！
![dc621f0814d769da779a5f0ca63b80f9](https://github.com/takatoshi-inoue/photo_up/blob/master/dc621f0814d769da779a5f0ca63b80f9.jpg)
## アプリケーションの概要
### このアプリは画像を投稿し、投稿した画像に対してコメントでコミュニケーションを取ることが出来ます。
## アプリケーションの機能一覧
### ログイン機能(ユーザー登録）
### 検索機能
### 画像投稿機能、（画像を投稿したユーザのみ編集、削除が可能）
### コメント機能、非同期になっていますのでチャットとしてリアルタイムで対話が可能です。（コメントをするにはユーザー登録が必須です）
## アプリケーション内で使用している記述一覧
### デプロイ: AWSのEC2サーバを使用しています。
    webサーバ: Nginx
    アプリケーションサーバ: Unicorn
    使用している言語: HTML,CSS,Ruby,JavaScript
    データベースサーバ: MySQL
　　



## photo_up DB設計

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
