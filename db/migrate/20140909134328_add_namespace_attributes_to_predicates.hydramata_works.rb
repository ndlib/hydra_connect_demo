# This migration comes from hydramata_works (originally 20140909133333)
class AddNamespaceAttributesToPredicates < ActiveRecord::Migration
  def change
    add_column :hydramata_works_predicates, :namespace_context_prefix , :string
    add_column :hydramata_works_predicates, :namespace_context_url , :string
    add_column :hydramata_works_predicates, :namespace_context_name , :string
  end
end
