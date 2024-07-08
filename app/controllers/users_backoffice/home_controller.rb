class UsersBackoffice::HomeController < UsersBackofficeController
  def index
    @questions = Question.order(:id).last_questions(params[:page])
  end
end
