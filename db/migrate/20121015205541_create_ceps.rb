class CreateCeps < ActiveRecord::Migration
  def change
    create_table :ceps do |t|
      t.string :codigo_postal
      t.string :logradouro
      t.string :bairro
      t.string :cidade
      t.string :estado

      t.timestamps
    end
  end
end
