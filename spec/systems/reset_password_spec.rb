# frozen_string_literal: true

require 'rails_helper'

describe 'Reset password', type: :system do
  let(:selectors) do
    {
      logo: '.app-main__logo',
      description: '.app-main__description',
      form_message: '.message',
      form_password: 'form',
      password_field: 'user[password]',
      password_confirmation_field: 'user[password_confirmation]'
    }
  end

  it 'displays the reset password screen' do
    visit_reset_password_path

    expect(page).to have_css(selectors[:logo])
    expect(page).to have_content(I18n.t('devise.passwords.description'))

    within selectors[:form_password] do
      expect(page).not_to have_css(selectors[:form_message])
      expect(page).to have_field(selectors[:password_field], type: :password)
      expect(page).to have_field(selectors[:password_confirmation_field], type: :password)
      expect(page).to have_button(I18n.t('devise.passwords.change_password'))
      expect(page).to have_button(I18n.t('devise.passwords.change_password'))
    end
  end

  context 'given valid data' do
    it 'shows the success message' do
      visit_reset_password_path

      within selectors[:form_password] do
        fill_in('New password', with: 'password')
        fill_in('Confirm new password', with: 'password')

        click_button(I18n.t('devise.passwords.change_password'))

        expect(page).to have_css(selectors[:form_message])
        expect(page).to have_content(I18n.t('devise.message.flash'))
        expect(page).to have_content(I18n.t('devise.passwords.updated_not_active'))
      end
    end
  end

  context 'given invalid data' do
    it 'shows the error messages' do
      visit_reset_password_path

      within selectors[:form_password] do
        fill_in('New password', with: '123')
        fill_in('Confirm new password', with: '456')

        click_button(I18n.t('devise.passwords.change_password'))

        expect(page).to have_css(selectors[:form_message])
        expect(page).to have_content(I18n.t('devise.message.error'))
      end
    end
  end
end

private

def visit_reset_password_path
  raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
  Fabricate(:user, reset_password_token: hashed, reset_password_sent_at: Time.current)

  visit edit_user_password_path(reset_password_token: raw)
end
