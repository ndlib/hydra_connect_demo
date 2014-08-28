ActiveAdmin.register Hydramata::Works::WorkTypes::Storage, as: 'WorkType' do
  index do
    column :name_for_application_usage
    column :identity
    column :work_type_with_predicate_set, 'Predicate (Predicate Set)' do |predicate|
      content_tag(
        'ol',
        predicate.predicate_sets.collect { |predicate_set|
          content_tag(
            'li',
            content_tag(
              'ol',
              predicate_set.predicates.collect {|predicate|
                content_tag(
                  'li',
                  link_to("#{predicate.name_for_application_usage} (#{predicate_set.identity})", admin_predicate_path(predicate))
                )
              }.join("\n").html_safe
            )
          )
        }.join("\n").html_safe
      )
    end
    column :created_at
    column :updated_at
    actions
  end

end
