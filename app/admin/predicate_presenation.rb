ActiveAdmin.register Hydramata::Works::PredicatePresentationSequences::Storage, as: 'PredicatePresentationSequencesStorage' do
  menu label: 'Predicate Presentations'
  permit_params config.resource_column_names - ['id', 'created_at', 'updated_at']
  index do
    column :predicate_set, 'Predicate Set' do |presentation|
      link_to "#{presentation.predicate_set.identity} (#{presentation.predicate_set.work_type.identity})", admin_predicate_sets_storage_path(presentation.predicate_set)
    end
    column :predicate, 'Predicate' do |presentation|
      link_to presentation.predicate.identity, admin_predicates_storage_path(presentation.predicate)
    end
    column :presentation_sequence
    column :created_at
    column :updated_at
    actions
  end
end
