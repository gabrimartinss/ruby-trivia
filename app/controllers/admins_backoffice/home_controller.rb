class AdminsBackoffice::HomeController < AdminsBackofficeController
  def index
    @total_users = AdminStatistic.find_by_event(AdminStatistic::EVENTS[:total_users]).value
    @total_questions = AdminStatistic.find_by_event(AdminStatistic::EVENTS[:total_questions]).value
    @users = User.all.order(:id)
  end
end
