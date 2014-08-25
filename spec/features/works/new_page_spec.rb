feature 'Works#new page' do
  before do
    load "#{Rails.root}/db/seeds.rb"
  end
  scenario 'Visit the works/article/new page' do
    visit 'works/article/new'
    expect(page).to have_css('.dc-title .values')
    expect(page).to have_css('.dc-abstract .values')
  end
end
