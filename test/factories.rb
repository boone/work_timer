FactoryBot.define do
  factory :client do
    name 'Foo Inc.'
  end

  factory :project do
    client
    title 'Hard Work'
  end

  factory :event do |f|
    f.project
    f.comment 'An event'
    f.start { 1.hour.ago }
    f.end { Time.now }
  end
end
