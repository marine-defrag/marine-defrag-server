class AddDocumentUrlToPagesAndResources < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :document_url, :text
    add_column :resources, :document_url, :text
  end
end
