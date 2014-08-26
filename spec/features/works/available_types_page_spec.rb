feature 'Works#available_types page' do
  before do
    load "#{Rails.root}/db/seeds.rb"
  end
  scenario 'Visit the works/available_types page' do
    visit 'works/available_types'
    expect(page).to have_css('.available-types .work-type .name', count: 2)
    expect(page).to have_css('.available-types .work-type .description', count: 2)
    expect(page).to have_css('.work-type .btn[href="/works/document/new"]')
    expect(page).to have_css('.work-type .btn[href="/works/article/new"]')
  end
end
