# This migration comes from hydramata_works (originally 20140627140840)
class AddingItemPropSchemaDotOrgToPredicate < ActiveRecord::Migration
  def change
    add_column :hydramata_works_predicates, :itemprop_schema_dot_org, :string
  end
end
