class CreateUserInteractions < ActiveRecord::Migration[7.1]
  def change
    create_table :user_interactions do |t|
      t.string :filter_type
      t.datetime :request_on

      t.timestamps
    end
  end
end
