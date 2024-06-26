class UsersBackoffice::SearchController < UsersBackofficeController
  def questions
    @questions = Question._search_(params[:page], params[:term])
  end
end
