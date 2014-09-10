# This migration comes from hydramata_works (originally 20140910144244)
class AddValuePresenterClassNameToPredicate < ActiveRecord::Migration
  def change
    add_column :hydramata_works_predicates, :value_presenter_class_name, :string
  end
end
