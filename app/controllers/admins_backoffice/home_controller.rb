class AdminsBackoffice::HomeController < AdminsBackofficeController
  def index
    total_users_statistic = AdminStatistic.find_by_event(AdminStatistic::EVENTS[:total_users])
    @total_users = total_users_statistic ? total_users_statistic.value : 0

    total_questions_statistic = AdminStatistic.find_by_event(AdminStatistic::EVENTS[:total_questions])
    @total_questions = total_questions_statistic ? total_questions_statistic.value : 0

    @users = User.all.order(:id)
  end
end
