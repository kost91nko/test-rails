class AddCompanyRefToFactories < ActiveRecord::Migration
  def self.up
    change_table :factories do |t|
      t.references :company
    end
    #add a foreign key
    execute <<-SQL
      ALTER TABLE factories
        ADD CONSTRAINT fk_factories_companies
        FOREIGN KEY (company_id)
        REFERENCES companies(id)
    SQL
  end

  def self.down
    execute "ALTER TABLE factories DROP FOREIGN KEY fk_factories_companies"
  end
end
