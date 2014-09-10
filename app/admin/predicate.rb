ActiveAdmin.register Hydramata::Works::Predicates::Storage, as: 'PredicatesStorage' do
  menu label: 'Predicates'

  controller do
    def permitted_params
      params.permit(predicates_storage: self.class.resource_class.column_names - ['id', 'created_at', 'updated_at'])
    end
  end

  index do
    column :name_for_application_usage
    column :identity
    column :work_type_with_predicate_set, 'Work Type (Predicate Set)' do |predicate|
      content_tag(
        'ol',
        predicate.predicate_sets.collect { |predicate_set|
          content_tag(
            'li',
            link_to(
              predicate_set,
              admin_predicate_sets_storage_path(predicate_set.work_type)
            )
          )
      }.join(" ").html_safe )
    end
    column :created_at
    column :updated_at
    actions
  end
end
