class DbManager
  def create_table(db_path, name, opt)
    fields = opt.map { |key, value| "#{key} #{value}" }.join(', ')
    sql = "CREATE TABLE IF NOT EXISTS #{name} (#{fields})"

    SQLite3::Database.new(db_path) { |db| db.execute(sql) }
  end
end
