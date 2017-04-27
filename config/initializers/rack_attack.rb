class Rack::Attack

	throttle('http://localhost:3000/api/v1_ip', limit:2, period:10) do |req|
		req.ip if req.subdomain == 'http://localhost:3000/api/v1'
	end

	throttle('logins_ip', limit:5, period:20.seconds) do |req|
		if req.path == '/login' && req.post?
			req.params['email'].presence
		end
	end

	class Request < ::Rack::Request
		def subdomain
			host.split('.').first
		end
	end

end