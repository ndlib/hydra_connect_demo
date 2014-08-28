ActiveAdmin.register Hydramata::Works::PredicateSets::Storage, as: 'PredicateSet' do
  index do
    column :work_type, 'Work Type' do |predicate_set|
      link_to predicate_set.work_type.identity, admin_work_type_path(predicate_set.admin_work_type_path)
    end
    column :identity
    column :presentation_sequence
    actions
  end
end
