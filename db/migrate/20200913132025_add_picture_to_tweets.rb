class AddPictureToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :picture, :string
  end
end
