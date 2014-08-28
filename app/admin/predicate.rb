ActiveAdmin.register Hydramata::Works::Predicates::Storage, as: 'Predicate' do
  index do
    column :name_for_application_usage
    column :identity
    actions
  end
end
