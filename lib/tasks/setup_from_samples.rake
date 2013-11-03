desc "Setup a test app by copying the samples"
task setup_from_samples: :environment do
  # config/database.yml
  FileUtils.cp "#{Rails.root}/config/database.yml.sample",
    "#{Rails.root}/config/database.yml"

  # config/initializers/secret_token.rb
  FileUtils.cp "#{Rails.root}/config/initializers/secret_token.rb.sample",
    "#{Rails.root}/config/initializers/secret_token.rb"

  puts <<EOS
Remember to update the content in config/database.yml and
config/initializers/secret_token.rb before you use them in
production!
EOS
end
