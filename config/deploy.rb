# # config valid only for current version of Capistrano
# # capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
# lock '3.14.1'

# # Capistranoのログの表示に利用する
# set :application, 'photo_up'

# # どのリポジトリからアプリをpullするかを指定する
# set :repo_url,  'git@github.com:takatoshi-inoue/photo_up.git'

# # バージョンが変わっても共通で参照するディレクトリを指定
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# set :rbenv_type, :user
# set :rbenv_ruby, '2.6.5' #カリキュラム通りに進めた場合、2.6.5です

# # どの公開鍵を利用してデプロイするか
# set :ssh_options, auth_methods: ['publickey'],
#                   keys: ['~/.ssh/photo_up10.pem'] 
                  
# # プロセス番号を記載したファイルの場所
# set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# # Unicornの設定ファイルの場所
# set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
# set :keep_releases, 5

# # デプロイ処理が終わった後、Unicornを再起動するための記述
# after 'deploy:publishing', 'deploy:restart'
# namespace :deploy do
#   task :restart do
#     invoke 'unicorn:restart'
#   end
# end


# config valid for current version and patch releases of Capistrano
lock "~> 3.11.1"

set :application, "appname"
# どのリポジトリからアプリをpullするかを指定する
set :repo_url, "git@github.com:ユーザー名/appname.git"

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :linked_files, fetch(:linked_files, []).push("config/master.key")#ここ注意

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1'

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/ここは自分の.pem']

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'upload master.key'#ここ注意
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/master.key', "#{shared_path}/config/master.key")#ここ注意
    end
  end
  before :starting, 'deploy:upload'
  after :finishing, 'deploy:cleanup'
end

set :default_env, {
  rbenv_root: "/usr/local/rbenv",
  path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH",
  AWS_ACCESS_KEY_ID: ENV["AWS_ACCESS_KEY_ID"],
  AWS_SECRET_ACCESS_KEY: ENV["AWS_SECRET_ACCESS_KEY"]
}