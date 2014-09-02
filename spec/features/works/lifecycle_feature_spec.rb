feature 'Works#available_types page' do
  before do
    load "#{Rails.root}/db/seeds.rb"
  end
  scenario 'Creating a work with valid data' do
    # Select Work Type
    visit 'works/available_types'
    expect(page).to have_css('.available-types .work-type .name', count: 2)
    expect(page).to have_css('.available-types .work-type .description', count: 2)
    expect(page).to have_css('.work-type .btn[href="/works/document/new"]')
    expect(page).to have_css('.work-type .btn[href="/works/article/new"]')
    find('.work-type .btn[href="/works/article/new"]').click

    # New Work
    within('form.work') do
      expect(page).to have_css('fieldset.required caption', text: 'Required Article Attributes')
      within('fieldset.required') do
        expect(page).to have_css('#label_for_work_dc_title', text: 'Title')
        fill_in('work_dc_title_0', with: 'My Title')
        expect(page).to have_css('#label_for_work_dc_abstract', text: 'Abstract')
        fill_in('work_dc_abstract_0', with: 'My Abstract')
      end
      # Create Work
      find('.actions input[name="commit"]').click
    end

    # @TODO - Message saying work was created

    # Show Work
    identity = page.current_path.split("/").last
    expect(page).to have_css('.required .metadata .value.dc-title', text: 'My Title')
    expect(page).to have_css('.required .metadata .value.dc-abstract', text: 'My Abstract')

    expect(page).to have_css(%(.actions a[href="/works/edit/#{identity}"]), text: "Edit this Article")
    find(%(.actions a[href="/works/edit/#{identity}"])).click

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
      # # Update Work
      # find('.actions input[name="commit"]').click
    end
  end

  scenario 'Creating a work with invalid data' do
    # Select Work Type
    visit 'works/available_types'
    expect(page).to have_css('.available-types .work-type .name', count: 2)
    expect(page).to have_css('.available-types .work-type .description', count: 2)
    expect(page).to have_css('.work-type .btn[href="/works/document/new"]')
    expect(page).to have_css('.work-type .btn[href="/works/article/new"]')
    find('.work-type .btn[href="/works/article/new"]').click

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
