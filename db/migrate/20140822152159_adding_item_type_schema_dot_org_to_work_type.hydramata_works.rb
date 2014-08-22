# This migration comes from hydramata_works (originally 20140627134133)
class AddingItemTypeSchemaDotOrgToWorkType < ActiveRecord::Migration
  def change
    add_column :hydramata_works_types, :itemtype_schema_dot_org, :string
  end
end
