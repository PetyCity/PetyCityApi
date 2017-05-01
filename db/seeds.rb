

def generate_code(number)
  charset = Array('A'..'Z') + Array('a'..'z')
  Array.new(number) { charset.sample }.join
end

rols = ["admin","company","customer","company_customer"]


# Company
# 1.times do |index|
 
#  Company.create(
#    nit: Faker::Number.unique.number(10),
#    name_comp: Faker::Company.name , 
#    address: Faker::Address.street_address,
#    city: Faker::Address.city,
#    phone: Faker::Number.number(7)  ,
#    permission: false,
#    user_id: 1 ,
#    image_company: File.open(File.join(Rails.root, '/test/img/park.png'))
#   )
  
# end



#49.times do |index|
 # Product.create(
 # name_product: Faker::Pokemon.unique.name,
 # description: Faker::Pokemon.unique.location,
 # status: true,
 # value: Faker::Number.decimal(2, 3) ,
 # amount: Faker::Number.between(1, 30),
 # company_id: 5
 #)
  
#end

  
# for index in 1..200
  

#   puts product_id: index%50
#  if index % 6 == 0 
#    Image.create( 
#     name_image: File.open(File.join(Rails.root, '/test/img/producto1.png')),
#     product_id: ( index % 50 ) +3
#    )
  
#  elsif index % 6 ==1
#    Image.create( 
#     name_image: File.open(File.join(Rails.root, '/test/img/producto2.jpg')),
#     product_id:  ( index % 50 ) +3
#    )
   
#  elsif index % 6 == 2
#    Image.create( 
#    name_image: File.open(File.join(Rails.root, '/test/img/producto3.jpg')),
#    product_id:  ( index % 50 ) +3
#    )

#  elsif index % 6 == 3
#     Image.create( 
#     name_image: File.open(File.join(Rails.root, '/test/img/producto4.jpg')),
#     product_id:  ( index % 50 ) +3
#     )

#   elsif index % 6 == 4
#     Image.create( 
#     name_image: File.open(File.join(Rails.root, '/test/img/producto5.jpg')),
#     product_id:  ( index % 50 ) +3
#     )

#   else

#     Image.create( 
#      name_image: File.open(File.join(Rails.root, '/test/img/producto6.png')),
#      product_id:  ( index % 50 ) +3
#     )

#   end
  

# end


#  for index in 2..12

#   if index % 6 == 2

#      Publication.create( 

#        title: Faker::Lorem.sentence,
#        body_publication: Faker::Lorem.paragraphs,
#        user_id: 3,
#        image_publication:File.open(File.join(Rails.root, '/test/img/producto6.png'))
#      )

#     elsif index % 6 == 3


#      Publication.create( 
#        title: Faker::Lorem.sentence,
#        body_publication: Faker::Lorem.paragraphs,
#        user_id: 3,
#        image_publication:File.open(File.join(Rails.root, '/test/img/producto2.jpg'))
#       )

#     elsif index % 6 == 4

#       Publication.create( 
#       title: Faker::Lorem.sentence,
#        body_publication: Faker::Lorem.paragraphs,
#        user_id: 3,
#        image_publication:File.open(File.join(Rails.root, '/test/img/producto1.png'))
#      )

#   else

#        Publication.create( 
#        title: Faker::Lorem.sentence,
#        body_publication: Faker::Lorem.paragraphs,
#        user_id: 3,
#        image_publication:File.open(File.join(Rails.root, '/test/img/producto4.jpg'))
      
#       )
#    end
# end


 # 12.times do |index|
 # CommentPublication.create( 
 #   body_comment_Publication: Faker::Lorem.paragraph,
 #   publication_id: index%12 , 
 #   user_id: 2
  
 # )

 # end

# 200.times do |index|

#     CommentProduct.create(
#     body_comment_product: Faker::Lorem.paragraph,
#     product_id: index%50,
#     user_id: 3
#   )

# end



 # 5.times do |indes|
 #   Category.create( 
 #     name_category: Faker::StarWars.character ,
 #     details:Faker::StarWars.quote
 #     )
 # end

# for num in 1..50
#   CategoryProduct.create( product_id:(num%50)+1, category_id:(num%5)+1)
# end

#for num in 1..100
 # Transaction.create( product_id: num , cart_id: num, amount: 10)
#end


#for num in 1..100
 #  Sale.create( product_id: num , cart_id: num, amount: 10)
#end
# 1.times do |index|
#   Cart.create( user_id:num, 
#   total_price: 0)
# end

