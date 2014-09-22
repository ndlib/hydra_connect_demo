require 'rails_helper'
require 'support/site_prism_pages'

feature 'Works#available_types page' do
  before do
    # The seeds are very important; They define the structures.
    load "#{Rails.root}/db/seeds.rb"
  end

  scenario 'Creating a work with valid data' do

    on_this_page(WorksAvailableTypesPage) do |the_page|
      the_page.load
      expect(the_page).to be_all_there
      the_page.link_for_new('article').click
    end

    on_this_page(WorkNewPage) do |the_page|
      expect(the_page).to be_all_there
      the_page.fill_in('dc_title', with: 'My Title')
      the_page.fill_in('dc_abstract', with: 'My Abstract')
      the_page.fill_in('dc_contributor_name', with: 'Jeremy Friesen')
      the_page.fill_in('dc_contributor_role', with: 'Author')
      the_page.attach(
        'file', with: [
          File.expand_path('../../../../LICENSE', __FILE__),
          File.expand_path('../../../../README.md', __FILE__)
        ]
      )
      the_page.submit_button.click
    end

    # @TODO - Message saying work was created

    show_page = on_this_page(WorkShowPage) do |the_page|
      expect(the_page.text_for('dc_title')).to eq(['My Title'])
      expect(the_page.text_for('dc_abstract')).to eq(['My Abstract'])
      expect(the_page.text_for('dc_contributor_name')).to eq(['Jeremy Friesen'])
      expect(the_page.text_for('dc_contributor_role')).to eq(['Author'])
      expect(the_page.text_for('file')).to eq(['README.md', 'LICENSE'])
      expect(the_page.file[0][:href]).to match(/^\/.*_README.md$/)
      expect(the_page.file[1][:href]).to match(/^\/.*_LICENSE$/)
      the_page.edit_link.click
    end

    on_this_page(WorkEditPage) do |the_page|
      expect(the_page.existing_values_for('dc_title')).to eq(['My Title'])
      expect(the_page.existing_values_for('dc_abstract')).to eq(['My Abstract'])
      expect(the_page.existing_values_for('dc_contributor_name')).to eq(['Jeremy Friesen'])
      expect(the_page.existing_values_for('dc_contributor_role')).to eq(['Author'])
      expect(the_page.links_to_existing_files.map(&:text)).to eq(['README.md', 'LICENSE'])

      the_page.fill_in('dc_title', with: 'Another Title')
      the_page.fill_in('dc_abstract', with: 'Another Abstract')
      the_page.fill_in('dc_contributor_name', with: 'Dan Brubaker-Horst')
      the_page.fill_in('dc_contributor_role', with: 'Contributor')
      the_page.attach('file', with: [File.expand_path('../../../../Rakefile', __FILE__)])
      the_page.dettach('README.md')

      the_page.submit_button.click
    end

    on_this_page(WorkShowPage) do |the_page|
      expect(the_page.identity).to eq(show_page.identity)
      expect(the_page.text_for('dc_title')).to eq(['My Title', 'Another Title'])
      expect(the_page.text_for('dc_abstract')).to eq(['My Abstract', 'Another Abstract'])
      expect(the_page.text_for('dc_contributor_name')).to eq(['Jeremy Friesen', 'Dan Brubaker-Horst'])
      expect(the_page.text_for('dc_contributor_role')).to eq(['Author', 'Contributor'])
      expect(the_page.text_for('file')).to eq(['LICENSE', 'Rakefile'])
    end
  end

  scenario 'Creating a work with invalid data' do

    on_this_page(WorksAvailableTypesPage) do |the_page|
      the_page.load
      expect(the_page).to be_all_there
      the_page.new_article_link.click
    end

    on_this_page(WorkNewPage) do |the_page|
      the_page.fill_in('dc_abstract', with: 'My Abstract')
      the_page.submit_button.click
    end

    on_this_page(WorkEditPage) do |the_page|
      expect(the_page.existing_values_for('dc_title')).to eq([])
      expect(the_page.existing_values_for('dc_abstract')).to eq(['My Abstract'])
    end
  end

  scenario 'Making sure the file is clickable and downloadable' do
    file_path = File.expand_path('../../../../LICENSE', __FILE__)

    on_this_page(WorksAvailableTypesPage) do |the_page|
      the_page.load
      expect(the_page).to be_all_there
      the_page.new_article_link.click
    end

    on_this_page(WorkNewPage) do |the_page|
      the_page.fill_in('dc_title', with: 'My Title')
      the_page.attach('file', with: file_path)
      the_page.submit_button.click
    end

    on_this_page(WorkShowPage) do |the_page|
      the_page.file.first.click
    end

    # I downloaded the file
    expect(page.html).to eq(File.read(file_path))
  end
end
