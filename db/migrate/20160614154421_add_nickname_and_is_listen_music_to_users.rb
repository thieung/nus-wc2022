class AddNicknameAndIsListenMusicToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :is_listen_music, :boolean, default: true
  end
end
