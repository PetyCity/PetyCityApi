class Vote < ApplicationRecord
  
  has_many :products, primary_key: :votable_id, foreign_key: "id"
  
  def self.votes_by_votable_prom_product()     
     includes( :products)
     .where(votable_type: "Product")
     .group(:votable_id)
     .select('votable_id as id, SUM(vote_weight)/COUNT(vote_weight) as total')
              
       
  end
  def self.votes_by_votable_pop_product()
      includes( products: :images)     
      .where(votable_type: "Product")
      .group(:votable_id) 
      .select('votable_id ,COUNT(vote_weight) as num_votes')
      
      #.select('votable_id as id,COUNT(vote_weight) as num_votes')    
  end
end
