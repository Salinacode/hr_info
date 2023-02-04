class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :studname
      t.string :studemail

      t.timestamps
    end
  end
end
