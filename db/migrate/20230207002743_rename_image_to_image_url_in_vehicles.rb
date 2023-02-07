class RenameImageToImageUrlInVehicles < ActiveRecord::Migration[5.2]
  def change
    rename_column :vehicles, :image, :image_url
  end
end
