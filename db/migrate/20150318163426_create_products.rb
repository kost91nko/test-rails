class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.references :factory
      t.string :name
      t.string :description

      t.timestamps
    end

    #add a foreign key
    execute <<-SQL
      ALTER TABLE products
        ADD CONSTRAINT fk_products_factories
        FOREIGN KEY (factory_id)
        REFERENCES factories(id)
    SQL
  end

  def self.down
    drop_table :products
  end
end
T