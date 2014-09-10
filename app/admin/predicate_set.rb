ActiveAdmin.register Hydramata::Works::PredicateSets::Storage, as: 'PredicateSetsStorage' do
  menu parent: "Work Types Storages", label: "Predicate Sets"
  permit_params config.resource_column_names - ['id', 'created_at', 'updated_at']
  index do
    column :identity
    column :work_type, 'Work Type' do |predicate_set|
      link_to predicate_set.work_type.identity, admin_work_types_storage_path(predicate_set.work_type)
    end
    column :predicates, 'Predicates' do |predicate_set|
      content_tag(
        'ol',
        predicate_set.predicates.collect { |predicate|
          content_tag(
            'li',
            link_to(
              predicate.name_for_application_usage,
              admin_predicates_storage_path(predicate)
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
