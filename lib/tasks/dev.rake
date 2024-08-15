RAKEDEFAULT_PASSWORD = '@S123456'
DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Dropping DB...") { %x(rails db:drop) }
      show_spinner("Creating DB...") { %x(rails db:create) }
      show_spinner("Making Migrations...") { %x(rails db:migrate) }
      show_spinner("Registering Users...") { %x(rails dev:add_default_user) }
      show_spinner("Registering Subjects...") { %x(rails dev:add_subjects) }
      show_spinner("Registering Questions...") { %x(rails dev:add_answers_questions) }
    else
      puts "Você não está em desenvolvimento"
    end
  end

  desc "Cadastro Usuário Padrão"
  task add_default_user: :environment do
    users = [
      { email: "user@gmail.com", password: RAKEDEFAULT_PASSWORD, password_confirmation: RAKEDEFAULT_PASSWORD },
      { email: "teste@gmail.com", password: RAKEDEFAULT_PASSWORD, password_confirmation: RAKEDEFAULT_PASSWORD },
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
        #Cria a pergunta
        params =  { question: {
                  description: "Ipsi dumi sala hujifxi trus tes?",
                  subject: subject,
                  answers_attributes: []}
                  }
                  #cria as respostas
                  rand(2..5).times do |j|
                    params[:question][:answers_attributes].push(
                      { description: "Humjiu dou wopsyz", correct: false}
                    )
                  end
                  #aleatoriamente escolhe uma para ser a true
                  index = rand(params[:question][:answers_attributes].size)
                  params[:question][:answers_attributes][index] = { description: "Humjiu dou wopsyz", correct: true}
                  #cria com os parametros feitos acima
                  Question.create!(params[:question])
      end
    end
  end

  private

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    #yield que simboliza bloco de notas pode usado tanto "do" quando "{}", mas apenas se for código de uma linha só caso não usa o "do"  mesmo
    yield
    spinner.success("(#{msg_end})")
  end
end
