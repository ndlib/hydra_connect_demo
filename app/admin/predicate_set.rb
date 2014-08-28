ActiveAdmin.register Hydramata::Works::PredicateSets::Storage, as: 'PredicateSet' do
  menu :parent => "Work Types"
  index do
    column :identity
    column :work_type, 'Work Type' do |predicate_set|
      link_to predicate_set.work_type.identity, admin_work_type_path(predicate_set.work_type)
    end
    column :predicates, 'Predicates' do |predicate_set|
      content_tag(
        'ol',
        predicate_set.predicates.collect { |predicate|
          content_tag(
            'li',
            link_to(
              predicate.name_for_application_usage,
              admin_predicate_path(predicate)
            )
          )
      }.join(" ").html_safe )
    end
    column :presentation_sequence
    column :created_at
    column :updated_at
    actions
  end
end
