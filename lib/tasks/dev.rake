DEFAULT_PASSWORD = 123456
DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando DB...") { %x(rails db:drop) }
      show_spinner("Criando DB...") { %x(rails db:create) }
      show_spinner("Gerando Migrações...") { %x(rails db:migrate) }
      show_spinner("Cadastrando admin padrão...") { %x(rails dev:add_default_admin) }
      show_spinner("Cadastrando usuário padrão...") { %x(rails dev:add_default_user) }
      show_spinner("Cadastrando temas padrão...") { %x(rails dev:add_subjects) }
      show_spinner("Cadastrando Perguntas...") { %x(rails dev:add_answers_questions) }
    else
      puts "Você não está em desenvolvimento"
    end
  end

  desc "Cadastro Admin Padrão"
  task add_default_admin: :environment do
    admins = [
      { email: "admin@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "jhon_silva@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "yuna_downey@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "teste1@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "teste2@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "teste3@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "teste4@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "teste5@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "teste6@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "teste7@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "teste8@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "teste9@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "teste10@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "teste11@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "teste12@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
      { email: "teste13@gmail.com", password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD }
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

  desc "Adiciona Temas"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)
 
    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end

  desc "Adiciona Perguntas e respostas"
  task add_answers_questions: :environment do
    Subject.all.each do |subject|
      rand(8..10).times do |i|
        Question.create!(
          description: "Qual comando abre o console do rails?????",
          subject: subject
      )  
      end
    end
  end

  private

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    #yield que simboliza bloco de notas pode usado tanto "do" quando "{}", mas apenas se for código de uma linha só caso não usa o "do"  mesmo.
    yield
    spinner.success("(#{msg_end})")
  end
end