class UsersBackoffice::AnswerController < UsersBackofficeController
  def question
    if params[:answer_id].present?
      @answer = Answer.find(params[:answer_id])
      set_user_statistic(@answer)
    else
      flash[:alert] = "Please select an answer before confirming."
      redirect_to request.referer # ou para a página onde o formulário é exibido
    end
  end

  def reset_statistics
    if user_signed_in?
      user_statistic = UserStatistic.find_by(user: current_user)
      if user_statistic
        user_statistic.update(right_questions: 0, wrong_questions: 0)
        flash[:notice] = "Your statistics have been reset successfully."
      else
        flash[:alert] = "No statistics found to reset."
      end
    else
      flash[:alert] = "You need to sign in to reset your statistics."
    end
    redirect_to users_backoffice_statistic_path
  end

  private

  def set_user_statistic(answer)
    if user_signed_in?
      user_statistic = UserStatistic.find_or_create_by(user: current_user)
      if answer.correct?
        user_statistic.right_questions += 1
      else
        user_statistic.wrong_questions += 1
      end
      user_statistic.save
    end
  end
end
