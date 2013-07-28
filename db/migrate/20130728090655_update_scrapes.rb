class UpdateScrapes < ActiveRecord::Migration
  def change
    connection.execute(%q{
      alter table scrapes
      alter column diff_id
      type integer using cast(diff_id as integer)
    })
  end
end
