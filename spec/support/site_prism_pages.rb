require 'site_prism'
module SitePrism
  module Within
    def within(*args)
      new(*args).tap {|page| yield(page) }
    end
  end
  module WorkFormHelpers
    def existing_values_for(predicate)
      all(%(form.work .#{predicate.to_s.gsub('_', '-')}.existing-input)).map(&:value)
    end

    def fill_in(predicate, with: nil)
      find(%(form.work #work_#{predicate}_0)).set(with)
    end

    def attach(predicate, with: nil)
      find(%(form.work #work_#{predicate}_0)).set(with)
    end

    def dettach(file_name)
      page.check("Delete #{file_name}")
    end
  end
end

SitePrism::Page.extend(SitePrism::Within)

class WorksAvailableTypesPage < SitePrism::Page
  set_url '/works/available_types'
  element :new_document_link, %(.available-types .work-type .add-button[href="/works/document/new"])
  element :new_article_link, %(.available-types .work-type .add-button[href="/works/article/new"])
  elements :new_link_container, '.available-types .work-type'

  def link_for_new(work_type)
    find(%(.work-type .add-button[href="/works/#{work_type}/new"]))
  end
end

class WorkNewPage < SitePrism::Page
  include SitePrism::WorkFormHelpers
  set_url_matcher %r{/works/\w+/new}
  element :required_fieldset, 'form.work fieldset.required legend'
  element :dc_title_label, 'form.work fieldset.required #label_for_work_dc_title'
  element :dc_title_input, 'form.work fieldset.required #work_dc_title_0'

  element :optional_fieldset, 'form.work fieldset.optional legend'
  element :dc_abstract_label, 'form.work fieldset.optional #label_for_work_dc_abstract'
  element :dc_abstract_input, 'form.work fieldset.optional #work_dc_abstract_0'
  element :file_input, 'form.work fieldset.optional #work_file_0'

  element :submit_button, 'form.work .actions input[name="commit"]'

end

class WorkShowPage < SitePrism::Page
  elements :dc_title, '.required .metadata .property-value.value.dc-title'
  elements :dc_abstract, '.required .metadata .property-value.dc-abstract'
  elements :file, '.optional .metadata .property-value.file a'
  elements :actions, '.actions'

  def text_for(predicate)
    all(%(.metadata .property-value.#{predicate.to_s.gsub('_', '-')})).map(&:text)
  end

  def edit_link
    find(%(.actions a[href="/works/#{identity}/edit"]))
  end

  def identity
    current_path.split("/").last
  end
end

class WorkEditPage < SitePrism::Page
  include SitePrism::WorkFormHelpers

  element :required_fieldset, 'form.work fieldset.required legend'
  element :dc_title_label, 'form.work fieldset.required #label_for_work_dc_title'
  elements :dc_title_existing_input, 'form.work fieldset.required .property-value.dc-title .existing-input'
  element :dc_title_input, 'form.work fieldset.required #work_dc_title_0'

  element :optional_fieldset, 'form.work fieldset.optional legend'
  element :dc_abstract_label, 'form.work fieldset.required #label_for_work_dc_abstract'
  elements :dc_abstract_existing_input, 'form.work fieldset.required .property-value.dc-abstract .existing-input'
  element :dc_abstract_input, 'form.work fieldset.required #work_dc_abstract_0'

  element :optional_fieldset, 'form.work fieldset.optional legend'
  element :file_input, 'form.work fieldset.optional .property-input.file #work_file_0'
  elements :links_to_existing_files, 'form.work fieldset.optional .file.existing-input'

  element :submit_button, 'form.work .actions input[name="commit"]'

end