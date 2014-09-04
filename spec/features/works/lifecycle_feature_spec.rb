feature 'Works#available_types page' do
  before do
    load "#{Rails.root}/db/seeds.rb"
  end

  scenario 'Creating a work with valid data' do
    # Select Work Type
    visit 'works/available_types'
    expect(page).to have_css('.available-types .work-type .name', count: 2)
    expect(page).to have_css('.available-types .work-type .description', count: 2)
    expect(page).to have_css(%(.work-type .btn[href="#{new_work_path(work_type: 'document')}"]))
    expect(page).to have_css(%(.work-type .btn[href="#{new_work_path(work_type: 'article')}"]))
    find(%(.work-type .btn[href="#{new_work_path(work_type: 'article')}"])).click

    # New Work
    within('form.work') do
      expect(page).to have_css('fieldset.required caption', text: 'Required Article Attributes')
      within('fieldset.required') do
        expect(page).to have_css('#label_for_work_dc_title', text: 'Title')
        fill_in('work_dc_title_0', with: 'My Title')
        expect(page).to have_css('#label_for_work_dc_abstract', text: 'Abstract')
        fill_in('work_dc_abstract_0', with: 'My Abstract')
      end

      within('fieldset.optional') do
        expect(page).to have_css('#label_for_work_attachment', text: I18n.t('hydramata.core.properties.attachment.label'))
        attach_file(
          'work_attachment_0',
          [
            File.expand_path('../../../../LICENSE', __FILE__),
            File.expand_path('../../../../README.md', __FILE__)
          ]
        )
      end

      # Create Work
      find('.actions input[name="commit"]').click
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
    visit 'works/available_types'
    expect(page).to have_css('.available-types .work-type .name', count: 2)
    expect(page).to have_css('.available-types .work-type .description', count: 2)
    expect(page).to have_css(%(.work-type .btn[href="#{new_work_path(work_type: 'document')}"]))
    expect(page).to have_css(%(.work-type .btn[href="#{new_work_path(work_type: 'article')}"]))
    find(%(.work-type .btn[href="#{new_work_path(work_type: 'article')}"])).click

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
