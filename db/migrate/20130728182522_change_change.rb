class ChangeChange < ActiveRecord::Migration
  def change
    connection.execute(%q{
      alter table scrapes
      alter column change
      type text using cast(change as text)
    })
  end
end
