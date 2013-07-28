class UpdateScrapeStrings < ActiveRecord::Migration
  def change
    connection.execute(%q{
      alter table scrapes
      alter column content
      type text using cast(content as text)
    })
  end
end
