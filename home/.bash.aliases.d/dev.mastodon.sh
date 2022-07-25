function mastxup {
  for i in app/javascript/mastodon/locales/LA.json \
      config/locales/activerecord.LA.yml \
      config/locales/devise.LA.yml \
      config/locales/doorkeeper.LA.yml \
      config/locales/LA.yml \
      config/locales/simple_form.LA.yml \
      app/views/user_mailer/confirmation_instructions.LA.text.erb \
      app/views/user_mailer/password_change.LA.text.erb \
      app/views/user_mailer/reset_password_instructions.LA.text.erb \
      app/views/user_mailer/confirmation_instructions.LA.html.erb \
      app/views/user_mailer/password_change.LA.html.erb \
      app/views/user_mailer/reset_password_instructions.LA.html.erb
  do
      meld ${i/LA/en} ${i/LA/he}
  done
}
