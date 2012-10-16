class CourseTeacher < ActiveRecord::Base
  belongs_to :course
  belongs_to :teacher_user,
             :class_name  => 'User',
             :foreign_key => :teacher_user_id

  validates :course_id, :presence => true
  validates :teacher_user_id, :presence => true,
    :uniqueness => {:scope => [:course_id,:semester_value]}

  def semester=(semester)
    @semester = semester
    self.semester_value = semester.value
  end

  def semester
    @semester || (
      if !self.semester_value.blank?
        Semester.get_by_value(self.semester_value)
      end
    )
  end

  # 格式
  # [
  #   {:weekday => weekday, :number => [hour,hour2]},
  #   {:weekday => weekday, :number => [hour]}
  # ]
  def time_expression_array
    JSON.parse(self.time_expression || "[]")
  end

  def time_expression_array=(time_expression_array)
    self.time_expression = time_expression_array.to_json
  end

  #{
  # :weekday1 => numbers,
  # :weekday2 => numbers
  # }
  def time_expression_hash
    value = {}
    self.time_expression_array.each do |item|
      value[item["weekday"]] = item["number"]
    end
    value
  end

  def course_student_assigns
    CourseStudentAssign.where(
      :course_id => self.course_id,
      :teacher_user_id => self.teacher_user_id,
      :semester_value => self.semester_value
    )
  end

  def set_students(users)
    students = self.course.get_students(:semester=>self.semester,:teacher_user=>self.teacher_user)

    remove_users = students - users
    self.course_student_assigns.each do |assign|
      assign.destroy if remove_users.include?(assign.student_user)
    end

    add_users = users - students
    add_users.each do |user|
      user.add_course(
        :semester => self.semester,
        :course => self.course,
        :teacher_user => self.teacher_user
      )
    end
  end

  def self.get_by_params(course, semester, teacher_user)
    self.where(
      :course_id => course.id,
      :semester_value => semester.value,
      :teacher_user_id => teacher_user.id
    ).first
  end

  def self.get_all_by_semester(semester)
    self.where(
      :semester_value => semester.value
    )
  end

  module UserMethods
    def self.included(base)
      base.has_many :course_teachers, :foreign_key => :teacher_user_id
      base.has_many :courses, :through => :course_teachers
    end
  end
end
