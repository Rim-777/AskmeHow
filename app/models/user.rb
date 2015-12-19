class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :opinions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def author_of?(entity)
    self.id == entity.user_id
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

end
