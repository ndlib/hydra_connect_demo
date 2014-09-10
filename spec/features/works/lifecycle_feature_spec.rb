require 'rails_helper'
require 'support/site_prism_pages'

feature 'Works#available_types page' do
  before do
    load "#{Rails.root}/db/seeds.rb"
  end

  scenario 'Creating a work with valid data' do
    WorksAvailableTypesPage.within do |the_page|
      the_page.load
      expect(the_page).to be_all_there
      the_page.new_article_link.click
    end

    WorkNewPage.within do |the_page|
      expect(the_page).to be_all_there
      the_page.dc_title_input.set('My Title')
      the_page.dc_abstract_input.set('My Abstract')
      the_page.attachment_input.set(
        [
          File.expand_path('../../../../LICENSE', __FILE__),
          File.expand_path('../../../../README.md', __FILE__)
        ]
      )
      the_page.submit_button.click
    end

    # @TODO - Message saying work was created

    show_page = WorkShowPage.within do |the_page|
      expect(the_page.dc_title.map(&:text)).to eq(['My Title'])
      expect(the_page.dc_abstract.map(&:text)).to eq(['My Abstract'])
      expect(the_page.attachment.map(&:text)).to eq(['README.md', 'LICENSE'])
      expect(the_page.attachment[0][:href]).to match(/^\/.*_README.md$/)
      expect(the_page.attachment[1][:href]).to match(/^\/.*_LICENSE$/)
      the_page.edit_link.click
    end

    WorkEditPage.within do |the_page|
      expect(the_page.dc_title_existing_input.map(&:value)).to eq(['My Title'])
      expect(the_page.dc_abstract_existing_input.map(&:value)).to eq(['My Abstract'])
      expect(the_page.links_to_existing_attachments.map(&:text)).to eq(['README.md', 'LICENSE'])

      the_page.dc_title_input.set('Another Title')
      the_page.dc_abstract_input.set('Another Abstract')
      the_page.attachment_input.set([File.expand_path('../../../../Rakefile', __FILE__)])

      the_page.submit_button.click
    end

    WorkShowPage.within do |the_page|
      expect(the_page.identity).to eq(show_page.identity)
      expect(the_page.dc_title.map(&:text)).to eq(['My Title', 'Another Title'])
      expect(the_page.dc_abstract.map(&:text)).to eq(['My Abstract', 'Another Abstract'])
      expect(the_page.attachment.map(&:text)).to eq(['README.md', 'LICENSE', 'Rakefile'])
    end
  end

  scenario 'Creating a work with invalid data' do
    # Select Work Type
    WorksAvailableTypesPage.within do |the_page|
      the_page.load
      expect(the_page).to be_all_there
      the_page.new_article_link.click
    end

    WorkNewPage.within do |the_page|
      the_page.dc_abstract_input.set('My Abstract')
      the_page.submit_button.click
    end

    WorkEditPage.within do |the_page|
      expect(the_page.dc_title_existing_input.map(&:value)).to eq([''])
      expect(the_page.dc_abstract_existing_input.map(&:value)).to eq(['My Abstract'])
      the_page.dc_abstract_input.set('Another Abstract')
    end
  end

  scenario 'Making sure the attachment is clickable and downloadable' do
    attachment_path = File.expand_path('../../../../LICENSE', __FILE__)
    # Select Work Type
    WorksAvailableTypesPage.within do |the_page|
      the_page.load
      expect(the_page).to be_all_there
      the_page.new_article_link.click
    end

    WorkNewPage.within do |the_page|
      the_page.dc_title_input.set('My Title')
      the_page.attachment_input.set(attachment_path)
      the_page.submit_button.click
    end

    WorkShowPage.within do |the_page|
      expect(the_page).to be_all_there
      the_page.attachment.first.click
    end

    expect(page.html).to eq(File.read(attachment_path))
  end
end
