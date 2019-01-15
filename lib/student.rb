class Student
  attr_accessor :name, :grade

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
  end

  def self.save
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?, ?)", self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
  end

  def self.create_table
    table = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
      )
    SQL

    DB[:conn].execute(table)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end

  def self.create(name:, grade:)
    new_student = Student.new(name, grade)
    new_student.save
    new_student
  end

  private

  attr_reader :id

end
