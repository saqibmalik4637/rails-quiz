class AddVerifiedToQuestion < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :verified, :boolean, default: false
    add_column :questions, :verification_error, :string
  end
end
