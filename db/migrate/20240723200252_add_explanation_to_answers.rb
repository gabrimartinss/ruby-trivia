class AddExplanationToAnswers < ActiveRecord::Migration[7.1]
  def change
    add_column :answers, :explanation, :text
  end
end
