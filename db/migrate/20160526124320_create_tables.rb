class CreateTables < ActiveRecord::Migration
  def up
    create_table :user_alliances do |t|
      t.integer :alliance_id, null: false
      t.text :user_id, array: true, default: []
    end

    create_table :bets do |t|
      t.integer :game_id, null: false
      t.integer :user_id, null: false
      t.text :score_ids, array: true, default: []
      t.integer :total_money_bet, default: 0
      t.integer :total_money_win, default: 0
      t.boolean :locked, default: false
      t.datetime :last_changed_at
      t.timestamps
    end

    create_table :predict_champions do |t|
      t.integer :user_id, null: false
      t.integer :team_id, null: false
      t.integer :money, default: 0
      t.timestamps
    end

    create_table :investments do |t|
      t.integer :game_id, null: false
      t.integer :total, default: 0
      t.integer :remaining, default: 0
      t.timestamps
    end

    create_table :groups do |t|
      t.string :title
      t.string :title_vi
      t.integer :pos
    end

    create_table :teams do |t|
      t.string :key
      t.string :title
      t.string :title_vi
      t.string :code
      t.boolean :eliminated, default: false
      t.boolean :is_champion, default: false
    end

    create_table :scores do |t|
      t.string :name
    end

    create_table :rounds do |t|
      t.string :title
      t.string :title_vi
      t.integer :pos
      t.integer :money_rate, default: 0
      t.date :start_at
      t.date :end_at
      t.boolean :is_group_stage, default: true
    end

    create_table :games do |t|
      t.integer :round_id
      t.integer :group_id
      t.integer :pos
      t.integer :team1_id
      t.integer :team2_id
      t.string :unknown_team1_title_vi
      t.string :unknown_team2_title_vi
      t.datetime :play_at
      t.integer :score1
      t.integer :score2
      t.integer :score_id
      t.integer :winner
      t.boolean :locked, default: false
      t.timestamps
    end
  end

  def down
    drop_table :games
    drop_table :rounds
    drop_table :scores
    drop_table :teams
    drop_table :groups
    drop_table :investments
    drop_table :predict_champions
    drop_table :bets
    drop_table :user_alliances
  end
end
