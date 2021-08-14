class Message
	def self.not_found(record='record')
		"#{record} 레코드는 찾을 수 없습니다.."
	end

	def self.invalid_credentials
		'Invalid credentials - 권한 오류'
	end

	def self.invalid_token
		'Invalid token - 인증 토큰 오류'
	end

	def self.missing_token
		'Missing token - 인증 토큰이 필요합니다.'
	end

	def self.unauthorized
		'Unauthorized request - 권한 오류'
	end
	
	def self.account_created
		'Account created successfully - 계정이 성공적으로 생성되었습니다.'
	end

	def self.account_not_created
		'Account could not be created - 계정이 생성되지 않았습니다.'
	end

	def self.expired_token
		'Sorry, your token has expierd. Please login to continue - 로그인이 만료되었습니다. 다시 로그인해주세요.'
	end

	def self.account_destroyed
		'회원 탈퇴하였습니다.'
	end

	def self.menu_destroyed
		'메뉴가 삭제되었습니다.'
	end

	def self.shop_destroyed
		'상점이 삭제되었습니다.'
	end
end