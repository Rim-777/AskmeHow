class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :opinions
  has_many :comments
  has_many :authorizations, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter, :vkontakte]

  def author_of?(entity)
    self.id == entity.user_id
  end

  def not_author_of?(entity)
    !self.author_of?(entity)
  end

  def is_author_of!(entity)
    entity.user_id = self.id
  end


  def say_оpinion(opinionable, value)

    opinion = opinions.where(opinionable: opinionable).first
    if opinion.present?
      opinion.delete if opinion.is_changed?(value)
    else
      opinions.create(value: value, opinionable: opinionable)
    end

  end

  def self.find_by_oauth(oauth)
    authorization = Authorization.where(provider: oauth.provider, uid: oauth.uid.to_s).first
    return authorization.user if authorization

    tmp_email = oauth.info[:email] || "#{oauth.uid.to_s}@#{oauth.provider}.tmp"
    user = User.where(email: tmp_email).first
    if user
      user.authorizations.create(provider: oauth.provider, uid: oauth.uid.to_s)
    else
      tmp_password = "#{oauth.uid}"
      # Devise.friendly_token[0, 20]
      user = User.create!(email: tmp_email, password: tmp_password, password_confirmation: tmp_password)
      user.authorizations.create(provider: oauth.provider, uid: oauth.uid.to_s)
    end
    user
  end




end
