class UpdateDiffs < ActiveRecord::Migration
  def change
    connection.execute(%q{
      alter table diffs
      alter column user_id
      type integer using cast(user_id as integer)
    })
  end
end
