ActiveAdmin.register Hydramata::Works::WorkTypes::Storage, as: 'WorkTypesStorage' do
  menu label: 'Work Types'
  permit_params config.resource_column_names - ['id', 'created_at', 'updated_at']
  index do
    column :name_for_application_usage
    column :identity
    column :predicates, 'Predicates' do |work_type|
      content_tag(
        'ol',
        work_type.predicates.collect { |predicate|
          content_tag(
            'li',
            link_to(predicate, admin_predicates_storage_path(predicate))
          )
        }.join("\n").html_safe
      )
    end
    column :predicate_presentations, 'Predicate Presentations' do |work_type|
      content_tag(
        'ol',
        work_type.predicate_presentation_sequences.collect { |presentation|
          content_tag(
            'li',
            link_to(presentation, admin_predicate_presentations_storage_path(presentation))
          )
        }.join("\n").html_safe
      )
    end
    column :created_at
    column :updated_at
    actions
  end

end
