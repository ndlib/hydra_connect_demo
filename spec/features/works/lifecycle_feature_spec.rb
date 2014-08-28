feature 'Works#available_types page' do
  before do
    load "#{Rails.root}/db/seeds.rb"
  end
  scenario 'Visit the works/available_types page' do
    # Select Work Type
    visit 'works/available_types'
    expect(page).to have_css('.available-types .work-type .name', count: 2)
    expect(page).to have_css('.available-types .work-type .description', count: 2)
    expect(page).to have_css('.work-type .btn[href="/works/document/new"]')
    expect(page).to have_css('.work-type .btn[href="/works/article/new"]')
    find('.work-type .btn[href="/works/article/new"]').click

    # New Work
    within('form.work') do
      within('fieldset.required') do
        fill_in('work_dc_title_0', with: 'My Title')
        fill_in('work_dc_abstract_0', with: 'My Abstract')
      end
      # Create Work
      find('.actions input[name="commit"]').click
    end

    # @TODO - Message saying work was created

    # Show Work
    expect(page).to have_css('.required .metadata .value.dc-title', text: 'My Title')
    expect(page).to have_css('.required .metadata .value.dc-abstract', text: 'My Abstract')

    # @TODO - Link to edit the work
  end
end
