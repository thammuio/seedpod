class Student < ActiveRecord::Base
  # has_secure_password
  # belongs_to :user
  has_many :student_teams
  has_many :teams, through: :student_teams

  has_many :course_students
  has_many :student_courses, through: :course_students

  has_many :userstories

  accepts_nested_attributes_for :course_students

  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :student_name
  before_create :remove_space, :set_default_change_password
  # Student.skip_callback(:save, :before, :update_student_password)
  before_validation :generate_password

  before_create { generate_token(:auth_token) }
  before_save :set_student_user_name
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Student.exists?(column => self[column])
  end

  def generate_password
    unless Student.exists?(self.email)
      rand_pwd = "student123"#Array.new(8){rand(36).to_s(36)}.join
      self.password = rand_pwd
      self.psd = rand_pwd
    end
  end

  def self.authenticate(email, password)
    student = find_by_email(email)
    if student && student.password == BCrypt::Engine.hash_secret(password, student.password_salt)
      student
    else
      nil
    end
  end

  def encrypt_password
    unless Student.exists?(self.email)
      if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password = BCrypt::Engine.hash_secret(password, password_salt)
      end
    end
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserStoryMailer.password_reset(self).deliver
  end

  def set_student_user_name
    username = self.email.split("@")
    self.student_name = username[0].strip
  end

  def remove_space
    self.email = self.email.strip
  end

  def set_default_change_password
    self.is_pwd_change = "false"
  end
end