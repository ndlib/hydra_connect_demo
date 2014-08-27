feature 'Works#new page' do
  before do
    load "#{Rails.root}/db/seeds.rb"
  end
  scenario 'Visit the works/article/new page' do
    visit "works/article/new?#{ { attributes: { dc_title: ['Hello', 'World'] } }.to_query }"
    click_button('Save changes')
  end
end
