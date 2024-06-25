class UsersBackoffice::SearchController < UsersBackofficeController
  def questions
    @questions = Question.includes(:answers).page(params[:page])
  end
end
