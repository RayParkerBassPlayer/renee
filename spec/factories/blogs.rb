FactoryBot.define do
    factory(:blog) do
      sequence(:title) { |n| "blog ##{n}" }
      body { FFaker::Lorem.paragraph }
      user 
    end
  end
  