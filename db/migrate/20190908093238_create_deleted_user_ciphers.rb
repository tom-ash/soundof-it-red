class CreateDeletedUserCiphers < ActiveRecord::Migration[5.2]
  def change
    create_table :deleted_user_ciphers do |t|
      t.jsonb :original_user_cipher, null: false

      t.timestamps
    end
  end
end