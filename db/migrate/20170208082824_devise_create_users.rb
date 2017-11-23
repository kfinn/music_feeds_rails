# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :spotify_uid, null: false
      t.string :email, null: false

      t.string :spotify_credential_token, null: false
      t.string :spotify_credential_refresh_token, null: false
      t.datetime :spotify_credential_expires_at, null: false
      t.boolean :spotify_credential_expires, null: false

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :spotify_uid, unique: true
  end
end
