class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :url, unique: true, null: false, index: true
      t.string :body, null: false, default: ''
      t.timestamps
    end
  end
end
