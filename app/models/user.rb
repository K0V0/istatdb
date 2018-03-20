class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :settings, inverse_of: :user

  has_many :goods, inverse_of: :user

  has_many :tasks, inverse_of: :user

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def is_admin?
    self.is_admin == "t" ? true : false
  end

end
