# describe 'throttling urls' do
#   include Rack::Test::Methods

#   def app
#     Rails.application
#   end

#   describe 'throttle excessive requests by IP address' do
#   let(:limit) { 10 }

#     context 'number of requests is lower than the limit' do
#       it "does not chnage the request status" do
#         limit.times do
#           get '/show', {}, "REMOTE_ADDR" => "1.2.3.4"
#           expect(last_response.status).to_not eq 429
#         end
#       end
#     end

#     context 'number of requests is higher than the limit' do
#       it 'changes the request status to 429' do
#         (limit * 2).times do |i|
#           get '/show', {}, "REMOTE_ADDR" => "1.2.3.5"
#           expect(last_response.status).to eq(429) if i > limit
#         end
#       end
#     end
#   end
# end