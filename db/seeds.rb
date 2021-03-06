# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

# # User.create!(
# # 	username: "Admin",
# # 	email: "admin@example.com",
# # 	password: "password",
# # 	password_confirmation: "password",
# # 	admin: true,
# # 	member: false
# # )

# # Add users
# 5.times do |j|
# 	user = User.new
# 	user.username = Faker::Name.unique.first_name
# 	user.email = Faker::Internet.unique.email
# 	user.password = 'password'
# 	user.password_confirmation = 'password'
# 	user.admin = false
# 	user.member = true
# 	user.avatar.attach(io: URI.open("https://picsum.photos/200/200"), filename: "#{j}_avatar.jpg")
# 	user.save
# end

# # Random number generator
# psuedo_rng = Random.new

# # # Add categories
# # # 5.times do |_m|
# # # 	category = Category.new
# # # 	category.category = Faker::Vehicle.unique.make_and_model
# # # 	category.save
# # # end

# # Add blog posts
# 5.times do |i|
# 	post = Post.new
# 	post.title = Faker::Lorem.sentence(word_count: 3, random_words_to_add: 7)
# 	post.body = Faker::Lorem.paragraph_by_chars(number: 1500)
# 	rand_user = User.pluck(:id).sample
# 	post.user = User.find(rand_user)
# 	post.thumbnail.attach(io: URI.open("https://picsum.photos/1920/1080"), filename: "#{i}_thumbnail.jpg")
# 	post.banner.attach(io: URI.open("https://picsum.photos/1920/300"), filename: "#{i}_banner.jpg")
# 	post.views = Faker::Number.between(from: 1, to: 5000)
# 	rando_category = Category.pluck(:id).sample
# 	post.category = Category.find(rando_category)
# 	post.save
#     # Add comments
# 	(2 + psuedo_rng.rand(8)).times do |_j|
# 		rando_user = User.pluck(:id).sample
# 		comment = post.comments.build(body: Faker::Lorem.paragraph_by_chars(number: 500), user: User.find(rando_user))
# 		comment.save
#     # Add replies to comments
# 	psuedo_rng.rand(5).times do |_k|
# 		rando_user = User.pluck(:id).sample
# 		nested_comment = comment.comments.build(body: Faker::Lorem.paragraph_by_chars(number: 500), user: User.find(rando_user),
# 				reply: true)
# 		nested_comment.save
# 		end
#     end
# end

# Add images to products
products = Product.all
products.each do |product| 
	product.product_image_map.image.attach(io: URI.open("https://picsum.photos/500"), filename: "#{product.productCode}_product.jpg")
end
