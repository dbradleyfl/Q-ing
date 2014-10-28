require "rails_helper"


feature 'Guest Can View Index Page' do
  scenario 'homepage exists' do
    visit '/'
    expect(page).to have_content "Q-ing"
  end

end
