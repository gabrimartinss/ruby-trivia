class UsersBackoffice::HomeController < UsersBackofficeController
  def index
    @questions = Question.includes(:answers).page(params[:page])
  end
end
