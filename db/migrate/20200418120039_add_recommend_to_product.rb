class AddRecommendToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :recommend_status, :integer, null: false, default: 1
  end
end
