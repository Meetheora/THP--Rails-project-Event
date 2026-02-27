class AddValidatedToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :validated, :boolean
  end
end
