class UsersBackoffice::HomeController < UsersBackofficeController
  def index
    @questions = Question.last_questions(params[:page])
  end
end
