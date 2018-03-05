# require 'spec_helper'
#
# Capybara.app = Sinatra::Application
# set(:show_exceptions, false)
#
# describe 'the store creation path', {:type => :feature} do
#   it 'takes the user to the homepage where they can add a store' do
#     visit '/'
#     fill_in('store_name', with: 'Payless')
#     click_button('Add Store')
#     expect(page).to have_content('Payless')
#   end
# end
#
# describe 'the brand creation path', {:type => :feature} do
#   it 'takes the user to the homepage where they can add a brand' do
#     visit '/'
#     fill_in('brand_name', with: 'Nike')
#     fill_in('brand_price', with: '50')
#     click_button('Add Brand')
#     expect(page).to have_content('Nike')
#     expect(page).to have_content('$50.00')
#   end
# end
#
# describe 'the store detail path', {:type => :feature} do
#   it 'takes the user to the homepage where they can create a project' do
#     visit '/'
#     fill_in('store_name', with: 'Payless')
#     click_button('Add Store')
#     click_link('Payless')
#     expect(page).to have_content('Payless')
#   end
# end
#
# describe 'the add brand to store path', {:type => :feature} do
#   it 'lets user add brand to store' do
#     visit '/'
#     fill_in('store_name', with: 'Payless')
#     click_button('Add Store')
#     fill_in('brand_name', with: 'Nike')
#     fill_in('brand_price', with: '50')
#     click_button('Add Brand')
#     click_link('Payless')
#
#     select('Nike', from: 'brand_id')
#     click_button('Add Brand to Store')
#     expect(page).to have_content('Nike')
#   end
# end
#
# describe 'the update store path', {:type => :feature} do
#   it 'lets user update store name' do
#     visit '/'
#     fill_in('store_name', with: 'Payless')
#     click_button('Add Store')
#     click_link('Payless')
#
#     fill_in('store_name', with: 'Paymore')
#     click_button('Update Store')
#     expect(page).to have_content('Paymore')
#   end
# end
#
# describe 'the store remove path', {:type => :feature} do
#   it 'lets user remove store' do
#     visit '/'
#     fill_in('store_name', with: 'Payless')
#     click_button('Add Store')
#     click_link('Payless')
#
#     click_button('Remove Store')
#     expect(page).not_to have_content('Payless')
#   end
# end
