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

#for num in 1..100
 #  amountt= rand 1..110
#   Sale.create( product_id: num , cart_id: num, amount: amountt)
#end

#for num in 1..100    
 #  Category.create( name_category: generate_code(5) , details:generate_code(7))
# end
#for num in 1..100   
#  CategoryProduct.create( product_id:num+2, category_id:num)
#end

#for num in 1..100
   
 # Publication.create( title: generate_code(11),body_publication: generate_code(11),user_id: num )
#end
#
#for num in 1..100    
 #  CommentPublication.create( body_comment_Publication: generate_code(11), publication_id: num, user_id: num+1 )
 #end
for num in 10..100   
   numm= rand 10..100
 Sale.create( product_id: num , cart_id: num, amount: numm )
 end