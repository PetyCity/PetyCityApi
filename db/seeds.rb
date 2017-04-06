# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


def generate_code(number)
  charset = Array('A'..'Z') + Array('a'..'z')
  Array.new(number) { charset.sample }.join
end
rols = ["admin","company","customer","company_customer"]
 for num in 1..90
 	emmail = generate_code(5) + "@" + generate_code(5)
 	cedulla = rand 11111111..2111111111
  userr = User.create(email:emmail,password: 123456)
   userr.update(cedula: cedulla, name_user:generate_code(5),block:false,sendEmail:false,rol:rols[ rand 4])
  end
nit =1000000000
for num in 4..100
	nit = nit +num
	phonee= rand 11111111..111111111
 	Company.create(nit: nit ,name_comp: generate_code(5) , address:generate_code(5),city:generate_code(5),phone:phonee , permission:0,user_id: num )
 end


for num in 4..100
	valuee= rand 1..1100
	amountt= rand 1..1100
 	Product.create( name_product:generate_code(3), description: generate_code(10), status:true, value: valuee , amount:  amountt, company_id: num )
 end

for num in 5..100
	
 	Publication.create( title: generate_code(11),body_publication: generate_code(11),user_id: num )
end


for num in 5..100		
 	CommentPublication.create( body_comment_Publication: generate_code(11), publication_id: num, user_id: num )
 end

for num in 1..100		
 	Image.create( name_image: generate_code(5) , product_id: num )
 end


for num in 1..100		
 	CommentProduct.create( body_comment_product: generate_code(11), product_id: num, user_id: num )
 end


for num in 1..100		
 	CommentProduct.create( body_comment_product: generate_code(11), product_id: num, user_id: num )
end


for num in 1..100		
 	Cart.create( user_id:num, total_price: 0)
end	

for num in 1..100		
 	Category.create( name_category: generate_code(5) , details:generate_code(7))
end

for num in 1..100		
 	CategoryProduct.create( product_id:num, category_id:num)
end

for num in 1..100		
 	Transaction.create( product_id: num , cart_id: num, amount: 10)
end

for num in 1..100		
 	Sale.create( product_id: num , cart_id: num, amount: 10)
end








	