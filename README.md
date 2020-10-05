# 本アプリを閲覧いただき誠にありがとうございます！もしご要望があれば機能を追加していきます！
# コメントに非同期機能を追加しました。
# ーーーー追加実装予定ーーーー
# ユーザーのマイページにサムネイルを追加

# photo_up DB設計

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
