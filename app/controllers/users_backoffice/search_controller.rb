class UsersBackoffice::SearchController < UsersBackofficeController
  def questions
    if params[:term].present?
      @questions = Question._search_(params[:page], params[:term])
    elsif params[:subject_id].present?
      @questions = Question._search_subject_(params[:page], params[:subject_id])
    else
      @questions = Question.all.page(params[:page])
    end
  end
end