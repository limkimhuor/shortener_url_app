class CreateShortenedUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :shortened_urls do |t|
      t.text :original_url
      t.string :short_url
      t.string :sanitize_url

      t.timestamps
    end

    add_index :shortened_urls, :short_url, unique: true
  end
end
