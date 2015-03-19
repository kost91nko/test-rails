# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

  companies = Company.create([
     {:name => "Scand", :description => "Scand description"},
     {:name => "Integral", :description => "Integral description"},
     {:name => "Horizont", :description => "Horizont description"},
 ])

  factories = Factory.create([
     {:name => "Scand factory", :description => "Scand factory desc", :company_id => companies.first.id},
     {:name => "Scand factory 2", :description => "Scand factory 2 desc", :company_id => companies.first.id},
     {:name => "Integral factory", :description => "Integral factory desc", :company_id => companies[1].id},
 ])

  Product.create([
     {:name => "Product Scand factory", :description => "Product Scand factory desc", :factory_id => factories.first.id},
     {:name => "Product Integral factory", :description => "Product Integral factory desc", :factory_id => factories[1].id},
 ])