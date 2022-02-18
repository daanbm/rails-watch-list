class AddPictureUrlToLists < ActiveRecord::Migration[6.1]
  def change
    add_column :lists, :picture_url, :string
  end
end
