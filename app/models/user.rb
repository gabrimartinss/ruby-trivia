class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable

  has_one :user_profile
  accepts_nested_attributes_for :user_profile, reject_if: :all_blank
  
  # Validations 
  validate :password_complexity, on: :create
  validates :first_name, presence: true, length: { minimum:3 }, on: :update, unless: :reset_password_token_present?


  def full_name
    [self.first_name, self.last_name].join(' ')
  end

  # Callback
  after_create :set_statistic

  # Kaminari
  paginates_per 5

  private

  def set_statistic
    AdminStatistic.set_event(AdminStatistic::EVENTS[:total_users])
  end

  def reset_password_token_present?
    !!$global_params[:user][:reset_password_token]
  end

  def password_complexity
    if password.present? && !password.match(/(?=.*[A-Z])(?=.*[!@#$&*])/)
      errors.add :password, "must contain at least one uppercase letter and a special character (!@#$&*)"
    end
  end

end
