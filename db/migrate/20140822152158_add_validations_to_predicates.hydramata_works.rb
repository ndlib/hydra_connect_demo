# This migration comes from hydramata_works (originally 20140623200635)
class AddValidationsToPredicates < ActiveRecord::Migration
  def change
    add_column :hydramata_works_predicates, :validations, :text
  end
end
