# 本アプリを閲覧いただき誠にありがとうございます！
![dc621f0814d769da779a5f0ca63b80f9](https://github.com/takatoshi-inoue/photo_up/blob/master/dc621f0814d769da779a5f0ca63b80f9.jpg)
## 画像投稿wedアプリです。
## 投稿した画像についてユーザーの詳細ページでチャットが可能です！
　　
　　



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
