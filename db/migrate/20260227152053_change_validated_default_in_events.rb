class ChangeValidatedDefaultInEvents < ActiveRecord::Migration[8.0]
  def change
    change_column_default :events, :validated, false
    change_column_null :events, :validated, false, false
  end
end
