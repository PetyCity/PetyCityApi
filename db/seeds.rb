

def generate_code(number)
  charset = Array('A'..'Z') + Array('a'..'z')
  Array.new(number) { charset.sample }.join
end

rols = ["admin","company","customer","company_customer"]
rols_comp = ["veterinary","wholesaler","hairdressing","pethotel","trainer"]

# Company
 2.times do |index|

 Company.create(
    nit: Faker::Number.unique.number(10),
    name_comp: Faker::Company.name ,
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    phone: Faker::Number.number(7)  ,
    permission: false,
    user_id: (index+1) ,
    image_company: File.open(File.join(Rails.root, '/test/img/park.png')),
    c_rol: rols_comp[ rand 5]
   )

 end




200.times do |index|
   Product.create(
   name_product: Faker::Pokemon.name,
   description: Faker::Pokemon.location,
   status: true,
   value: Faker::Number.decimal(2, 3) ,
   amount: Faker::Number.between(1, 30),
   company_id: (index%2)+1
 )
end
#for num in 1..100
 # valuee= rand 1..1100
  #amountt= rand 1..1100
  #Product.create( name_product:generate_code(3), description: generate_code(10), status:true, value: valuee , amount:  amountt, company_id: 1 )
#end



  400.times do |index|

#   puts product_id: index%50
  if index % 6 == 0
    Image.create(
     name_image: File.open(File.join(Rails.root, '/test/img/producto1.png')),
     product_id: ( index % 200 ) +1
    )

  elsif index % 6 ==1
    Image.create(
     name_image: File.open(File.join(Rails.root, '/test/img/producto2.jpg')),
     product_id:  ( index % 200 ) +1
    )

  elsif index % 6 == 2
    Image.create(
    name_image: File.open(File.join(Rails.root, '/test/img/producto3.jpg')),
    product_id: ( index % 200 ) +1
    )

  elsif index % 6 == 3
     Image.create(
     name_image: File.open(File.join(Rails.root, '/test/img/producto4.jpg')),
     product_id:  ( index % 200 ) +1
     )

   elsif index % 6 == 4
     Image.create(
     name_image: File.open(File.join(Rails.root, '/test/img/producto5.jpg')),
     product_id:  ( index % 200 ) +1
     )

   else
     Image.create(
      name_image: File.open(File.join(Rails.root, '/test/img/producto6.png')),
      product_id:  ( index % 200 ) +1
     )
   end
 end
  
 
 100.times do |index|

   if index % 4 == 2

     Publication.create(
       title: Faker::Book.title ,
       body_publication: Faker::Lorem.paragraph ,
       user_id: 6,
       image_publication: File.open(File.join(Rails.root, '/test/img/producto6.png'))
     )
    elsif index % 4 == 3
      Publication.create(
        title: Faker::Book.title ,
        body_publication: Faker::Lorem.paragraph ,
        user_id: 5,
        image_publication: File.open(File.join(Rails.root, '/test/img/producto6.png'))
      )
     elsif index % 4 == 1
       Publication.create(
         title: Faker::Book.title ,
         body_publication: Faker::Lorem.paragraph ,
         user_id: 7,
         image_publication: File.open(File.join(Rails.root, '/test/img/producto6.png'))
       )

   else

     Publication.create(
       title: Faker::Book.title ,
       body_publication: Faker::Lorem.paragraph ,
       user_id: 14,
       image_publication: File.open(File.join(Rails.root, '/test/img/producto6.png'))
     )
    end
 end


  200.times do |index|
    CommentPublication.create(
    body_comment_Publication: Faker::Lorem.paragraph,
    publication_id: (index%100) +1 ,
    user_id: (index%8) +4
  )
  end

 400.times do |index|
     CommentProduct.create(
     body_comment_product: Faker::Lorem.paragraph,
     product_id: (index%200)+1,
     user_id: (index%10) +4
   )
 end



  10.times do |indes|
    Category.create(
      name_category: Faker::StarWars.character ,
      details:Faker::StarWars.quote
      )
  end

 for num in 1..300
   CategoryProduct.create( product_id:(num%200)+1, category_id:(num%10)+1)
 end
 10.times do |index|
   Cart.create( user_id:  (index%10)+4,
   total_price: 0)
 end
for num in 1..300
  Transaction.create( product_id: (num%200)+1 , cart_id: (num%10)+1, amount: (rand 1..100))
end


for num in 100..149
   Sale.create( product_id: (num%200)+1 , cart_id: (num%10)+1, amount: (rand 1..500))
end
