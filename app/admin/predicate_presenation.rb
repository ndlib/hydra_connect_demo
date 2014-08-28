ActiveAdmin.register Hydramata::Works::PredicatePresentationSequences::Storage, as: 'PredicatePresentation' do
  index do
    column :predicate_set, 'Predicate Set' do |presentation|
      link_to "#{presentation.predicate_set.identity} (#{presentation.predicate_set.work_type.identity})", admin_predicate_set_path(presentation.predicate_set)
    end
    column :predicate, 'Predicate' do |presentation|
      link_to presentation.predicate.identity, admin_predicate_path(presentation.predicate)
    end
    column :presentation_sequence
    column :created_at
    column :updated_at
    actions
  end
end
