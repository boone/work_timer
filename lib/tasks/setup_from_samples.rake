desc "Setup a test app by copying the samples"
task :setup_from_samples do
  config_path = File.expand_path('../../../config', __FILE__)

  # config/database.yml
  FileUtils.cp "#{config_path}/database.yml.sample",
    "#{config_path}/database.yml"

  # config/secrets.yml
  FileUtils.cp "#{config_path}/secrets.yml.sample",
    "#{config_path}/secrets.yml"

  puts <<EOS
Remember to update the content in config/database.yml and
config/secrets.yml before you use them in production!
EOS
end
