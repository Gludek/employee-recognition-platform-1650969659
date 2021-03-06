require 'rails_helper'

RSpec.describe 'Rewards handling allows' do
  let!(:admin) { create(:admin) }
  let!(:reward) { create(:reward) }

  before do
    sign_in admin
  end

  it 'Admin to perform CRUD operations around Rewards' do
    visit admins_root_path

    within('.section') do
      click_link 'Rewards list'
    end

    expect(page).to have_content 'Rewards'
    expect(page).to have_content reward.title
    expect(page).to have_content 'Edit'
    expect(page).to have_content 'Destroy'

    click_link 'New Reward'
    expect(page).to have_content 'New Reward'
    expect(page).to have_content 'Title'

    fill_in 'reward_title', with: 'new test title'
    click_on 'Create Reward'
    expect(page).to have_content 'Description can\'t be blank'
    expect(page).to have_content 'Price can\'t be blank'
    fill_in 'reward_description', with: 'new description'
    click_on 'Create Reward'
    expect(page).to have_no_content 'Description can\'t be blank'
    fill_in 'reward_price', with: 0.5
    click_on 'Create Reward'
    expect(page).to have_content 'Price must be greater than or equal to 1'
    fill_in 'reward_price', with: 3.5
    click_on 'Create Reward'
    expect(page).to have_no_content 'Price must be greater than or equal to 1'

    expect(page).to have_content 'new test title'
    expect(page).to have_content 'new description'
    expect(page).to have_content '3.5'
    expect(page).to have_content 'Reward was successfully created.'

    click_link 'Edit', match: :first
    fill_in 'reward_title', with: 'title'
    click_on 'Update Reward'
    expect(page).to have_content 'Reward was successfully updated.'
    click_link 'Destroy', match: :first
    expect(page).to have_content 'Reward was successfully destroyed.'
  end
end
