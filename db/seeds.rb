DEFAULT_PASSWORD = ENV['DEFAULT_PASSWORD'] # Você pode substituir isso por ENV['DEFAULT_PASSWORD'] se usar variáveis de ambiente

# Adiciona Admins Padrão
admins = [
  { email: ENV['ADMIN_EMAIL1'], password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD },
  { email: ENV['ADMIN_EMAIL2'], password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD }
]

admins.each do |admin|
  if admin[:email].present?
    Admin.find_or_create_by!(email: admin[:email]) do |a|
      a.password = admin[:password]
      a.password_confirmation = admin[:password_confirmation]
    end
    puts "Admin com email #{admin[:email]} criado ou encontrado."
  else
    puts "Email não definido para um dos administradores."
  end
end