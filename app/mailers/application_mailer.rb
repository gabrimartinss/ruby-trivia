class ApplicationMailer < ActionMailer::Base
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Bem-vindo ao RubyTrivia')
  end
end