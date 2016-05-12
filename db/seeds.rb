# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.all.empty?
  puts 'creating users Seed.'
  3.times do
    username = Faker::Internet.user_name
    password = '1234'
    avatar_path = Faker::Avatar.image(username, '50x50')
    User.create(username: username, password: password, avatar_path: avatar_path)

  end
end

if Post.all.empty?
  puts 'creating posts seed.'
  User.all.each do |user|
    10.times do
      user.posts.create(title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph(sentence_count=7, supplemental=true, random_sentences_to_add=3))
    end
  end
end


if Comment.all.empty?
  puts 'creating comment seed.'
  Post.all.each do |post|
    3.times do
      post.comments.create(name: Faker::Name.name, email: Faker::Internet.email, content: Faker::Lorem.paragraph(sentence_count=2, supplemental=true, random_sentences_to_add=3))
    end
  end
end