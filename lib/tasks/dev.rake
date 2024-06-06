DEFAULT_PASSWORD = 123456

namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando DB...") { %x(rails db:drop) }
      show_spinner("Criando DB...") { %x(rails db:create) }
      show_spinner("Gerando Migrações...") { %x(rails db:migrate) }
      show_spinner("Cadastrando admin padrão...") { %x(rails dev:add_default_admin) }
      show_spinner("Cadastrando usuário padrão...") { %x(rails dev:add_default_user) }

    else
      puts "Você não está em desenvolvimento"
    end
  end

  desc "Cadastro Admin Padrão"
  task add_default_admin: :environment do
    admins = [
      { email: "admin@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "jhon_silva@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "yuna_downey@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD }
    ]

    admins.each do |admin|
      Admin.create!(admin)
    end
  end

  desc "Cadastro Usuário Padrão"
  task add_default_user: :environment do
    users = [
      { email: "user@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "robert_carlos@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "looney_tunes@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD }
    ]

    users.each do |user|
      User.create!(user)
    end
  end

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    #yield que simboliza bloco de notas pode usado tanto "do" quando "{}", mas apenas se for código de uma linha só caso não usa o "do"  mesmo.
    yield
    spinner.success("(#{msg_end})")
  end
end