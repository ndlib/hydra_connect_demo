require 'site_prism'
module SitePrism::Within
  def within(*args)
    new(*args).tap {|page| yield(page) }
  end
end

SitePrism::Page.extend(SitePrism::Within)


class WorksAvailableTypesPage < SitePrism::Page
  set_url '/works/available_types'
  element :new_document_link, %(.work-type .btn[href="/works/document/new"])
  element :new_article_link, %(.work-type .btn[href="/works/article/new"])
  elements :new_link_container, '.available-types .work-type'
end

class WorkNewPage < SitePrism::Page
  set_url_matcher %r{/works/\w+/new}
  element :required_fieldset, 'form.work fieldset.required caption'
  element :dc_title_label, 'form.work fieldset.required #label_for_work_dc_title'
  element :dc_title_input, 'form.work fieldset.required #work_dc_title_0'
  element :dc_abstract_label, 'form.work fieldset.required #label_for_work_dc_abstract'
  element :dc_abstract_input, 'form.work fieldset.required #work_dc_abstract_0'

  element :optional_fieldset, 'form.work fieldset.optional caption'
  element :attachment_input, 'form.work fieldset.optional #work_attachment_0'

  element :submit_button, 'form.work .actions input[name="commit"]'
end

class WorkShowPage < SitePrism::Page
  elements :dc_title, '.required .metadata .value.dc-title'
  elements :dc_abstract, '.required .metadata .value.dc-abstract'
  elements :attachment, '.optional .metadata .value.attachment a'
  elements :actions, '.actions'

  def edit_link
    find(%(.actions a[href="/works/#{identity}/edit"]))
  end

  def identity
    current_path.split("/").last
  end
end

class WorkEditPage < SitePrism::Page
  element :required_fieldset, 'form.work fieldset.required caption'
  element :dc_title_label, 'form.work fieldset.required #label_for_work_dc_title'
  elements :dc_title_existing_input, 'form.work fieldset.required .dc-title .values .existing-input'
  element :dc_title_input, 'form.work fieldset.required #work_dc_title_0'
  element :dc_abstract_label, 'form.work fieldset.required #label_for_work_dc_abstract'
  elements :dc_abstract_existing_input, 'form.work fieldset.required .dc-abstract .values .existing-input'
  element :dc_abstract_input, 'form.work fieldset.required #work_dc_abstract_0'

  element :optional_fieldset, 'form.work fieldset.optional caption'
  element :attachment_input, 'form.work fieldset.optional .attachment #work_attachment_0'
  elements :links_to_existing_attachments, 'form.work fieldset.optional .attachment .values .existing-input'

  element :submit_button, 'form.work .actions input[name="commit"]'

  def dettach(attachment_name)
    page.check("Delete #{attachment_name}")
  end
end