require 'site_prism'

module SitePrism::Within
  def within(*args)
    new(*args).tap {|page| yield(page) }
  end
end

class AvailableTypesPage < SitePrism::Page
  extend SitePrism::Within
  set_url '/works/available_types'
  element :new_document_link, %(.work-type .btn[href="/works/document/new"])
  element :new_article_link, %(.work-type .btn[href="/works/article/new"])
  elements :new_link_container, '.available-types .work-type'
end

class NewWorkPage < SitePrism::Page
  extend SitePrism::Within
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

feature 'Works#available_types page' do
  before do
    load "#{Rails.root}/db/seeds.rb"
  end

  scenario 'Creating a work with valid data' do
    AvailableTypesPage.within do |page|
      page.load
      expect(page).to be_all_there
      page.new_article_link.click
    end

    NewWorkPage.within do |page|
      expect(page).to be_all_there
      page.dc_title_input.set('My Title')
      page.dc_abstract_input.set('My Abstract')
      page.attachment_input.set(
        [
          File.expand_path('../../../../LICENSE', __FILE__),
          File.expand_path('../../../../README.md', __FILE__)
        ]
      )
      page.submit_button.click
    end

    # @TODO - Message saying work was created

    # Show Work
    identity = page.current_path.split("/").last
    expect(page).to have_css('.required .metadata .value.dc-title', text: 'My Title')
    expect(page).to have_css('.required .metadata .value.dc-abstract', text: 'My Abstract')
    expect(page).to have_css('.optional .metadata .value.attachment a', text: 'README.md')
    expect(page).to have_css('.optional .metadata .value.attachment a', text: 'LICENSE')
    expect(page).to have_css(%(.actions a[href="#{edit_work_path(identity)}"]), text: "Edit this Article")

    find(%(.actions a[href="#{edit_work_path(identity)}"])).click
    # Edit Work
    within('form.work') do
      expect(page).to have_css('fieldset.required caption', text: 'Required Article Attributes')
      within('fieldset.required') do
        expect(page).to have_css('#label_for_work_dc_title', text: 'Title')
        expect(page).to have_css('.dc-title .values .existing-input[value="My Title"]')
        fill_in('work_dc_title_0', with: 'Another Title')

        expect(page).to have_css('#label_for_work_dc_abstract', text: 'Abstract')
        expect(page).to have_css('.dc-abstract .values .existing-input[value="My Abstract"]')
        fill_in('work_dc_abstract_0', with: 'Another Abstract')
      end
      # Update Work
      find('.actions input[value="Update this Article"]').click
    end

    updated_identity = page.current_path.split("/").last
    expect(updated_identity).to eq(identity)
    expect(page).to have_css('.required .metadata .value.dc-title', text: 'My Title')
    expect(page).to have_css('.required .metadata .value.dc-title', text: 'Another Title')
    expect(page).to have_css('.required .metadata .value.dc-abstract', text: 'My Abstract')
    expect(page).to have_css('.required .metadata .value.dc-abstract', text: 'Another Abstract')
    expect(page).to have_css(%(.actions a[href="#{edit_work_path(identity)}"]), text: "Edit this Article")
  end

  scenario 'Creating a work with invalid data' do
    # Select Work Type
    available_types_page = AvailableTypesPage.new
    available_types_page.load

    expect(available_types_page).to be_all_there
    available_types_page.new_article_link.click

    # New Work
    within('form.work') do
      expect(page).to have_css('fieldset.required caption', text: 'Required Article Attributes')
      within('fieldset.required') do
        expect(page).to have_css('#label_for_work_dc_title', text: 'Title')
        expect(page).to have_css('#label_for_work_dc_abstract', text: 'Abstract')
        fill_in('work_dc_abstract_0', with: 'My Abstract')
      end
      # Create Work
      find('.actions input[name="commit"]').click
    end

    # Edit Work
    identity = page.current_path.split("/").last
    within('form.work') do
      expect(page).to have_css('fieldset.required caption', text: 'Required Article Attributes')
      within('fieldset.required') do
        expect(page).to have_css('#label_for_work_dc_title', text: 'Title')
        fill_in('work_dc_title_0', with: 'Another Title')

        expect(page).to have_css('#label_for_work_dc_abstract', text: 'Abstract')
        expect(page).to have_css('.dc-abstract .values .existing-input[value="My Abstract"]')
        fill_in('work_dc_abstract_0', with: 'Another Abstract')
      end
      # # Update Work
      # find('.actions input[name="commit"]').click
    end
  end
end
