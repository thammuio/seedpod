class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :login
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]
  before_create :set_status_active

  has_one :user_type
  has_many :student_courses
  has_many :teams
  has_many :plans

  before_validation(on: :create) do
    
    if self.is_admin != true
      @passcode = Array.new(8){rand(36).to_s(36)}.join
      self.password = @passcode
    end
  end

  scope :find_faculty, :conditions => { :is_admin => nil }

  
  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.find_for_authentication(conditions)
   login = conditions.delete(:login)
    where(conditions).where(["username = :value OR email = :value", { :value => login }]).first
  end
  
  def set_status_active
    self.status = "Active"
  end

  def active_for_authentication?
    super && self.status == "Active"
  end

  def inactive_message
    "Sorry, this account has been deactivated."
  end
end