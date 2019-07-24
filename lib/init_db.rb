def init_db(db_path, db_manager)
  db_manager.create_table(
    db_path,
    'links',
    created_at: 'datetime',
    text: 'text',
    url: 'text'
  )

  db_manager.create_table(
    db_path,
    'memos',
    created_at: 'datetime',
    text: 'text'
  )

  db_manager.create_table(
    db_path,
    'tasks',
    created_at: 'datetime',
    text: 'text',
    due_date: 'datetime'
  )
rescue SQLite3::SQLException => e
  puts "Failed create db on #{@db_path}"
  abort e.message
end
