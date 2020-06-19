FactoryBot.define do
  factory :record do
    title {  Faker::Music.album }
    review { Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4) }
    display_name { Faker::Music::RockBand.name + ' - \'' +  Faker::Music.album   + '\' (' + Faker::Company.name + ')' }
    association :blog
    published { true }
    published_at { Time.current.utc }
  end
end
