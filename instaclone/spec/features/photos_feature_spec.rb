require 'rails_helper'

feature 'photos' do
  context 'no photos have been added' do
    scenario 'should display a prompt to add a photo' do
      visit '/photos'
      expect(page).to have_content 'No photos yet'
      expect(page).to have_link 'Add a photo'
    end
  end

  context 'adding photos' do
    scenario 'prompts user to fill out a form, then displays the new photo' do
      visit '/photos'
      click_link 'Add a photo'
      fill_in 'Caption', with: 'image'
      click_button 'Create Photo'
      expect(page).to have_content 'image'
      expect(current_path).to eq '/photos'
    end
  end

  context 'photos have been added' do
    before do
      @surfing = Photo.create(caption:'surfing.jpg')
      @swimming = Photo.create(caption:'swimming.jpg')
    end

    scenario 'display photos' do
      visit '/photos'
      expect(page).to have_content('surfing')
      expect(page).not_to have_content('No photos yet')
    end

    context 'viewing photos' do
      scenario 'lets a user view a photo' do
        visit '/photos'
        click_link 'View swimming'
        expect(page).to have_content 'swimming'
        expect(current_path).to eq "/photos/#{@swimming.id}"
      end
    end

    context 'editing photos' do
      scenario 'let a user edit a photo' do
        visit '/photos'
        click_link 'Edit surfing'
        fill_in 'Caption', with: 'surfinG'
        save_and_open_page
        click_button 'Update Photo'
        click_link 'View surfinG'
        expect(page).to have_content 'surfinG'
        expect(current_path).to eq "/photos/#{@surfing.id}"
      end
    end
  end
end
