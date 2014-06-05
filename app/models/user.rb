class User < ActiveRecord::Base
	attr_accessor :password
	before_save :encrypt_password
	before_save { self.email = email.downcase }
	before_create :create_auth_token

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { in: 6..80}, 
		format: { with: VALID_EMAIL_REGEX }, 
		uniqueness: { case_sensitive: false }
	validates_presence_of :password, :on => :create
	validates_presence_of :password_confirmation
	validates_confirmation_of :password
	validates :password, length: { minimum: 5 }


	def self.authenticate(email, password)
		user = find_by_email(email)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end

	def User.new_auth_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_auth_token
			self.auth_token = User.digest(User.new_auth_token)
		end

end
