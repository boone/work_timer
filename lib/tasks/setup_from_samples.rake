desc "Setup a test app by copying the samples"
task :setup_from_samples do
  config_path = File.expand_path('../../../config', __FILE__)

  # config/database.yml
  FileUtils.cp "#{config_path}/database.yml.sample",
    "#{config_path}/database.yml"

  # config/initializers/secret_token.rb
  FileUtils.cp "#{config_path}/initializers/secret_token.rb.sample",
    "#{config_path}/initializers/secret_token.rb"

  puts <<EOS
Remember to update the content in config/database.yml and
config/initializers/secret_token.rb before you use them in
production!
EOS
end
