# -*- coding: utf-8 -*-
class Student < ActiveRecord::Base
  belongs_to :user
  scope :no_team, joins('left join team_students on team_students.student_user_id = students.user_id').where('team_students.team_id is null')
  scope :of_team,lambda{|team|joins("inner join team_students on team_students.student_user_id = students.user_id").where("team_students.team_id = #{team.id}")}

  # --- 校验方法
  validates :real_name, :presence => true
  validates :sid, :uniqueness => { :if => Proc.new { |student| !student.sid.blank? } }
  validates :user, :presence => true

  validate do |student|
    if !student.user_id.blank?
      students = Student.find_all_by_user_id(student.user_id)
      teachers = Teacher.find_all_by_user_id(student.user_id)
      other_students = students-[student]
      if !other_students.blank? || !teachers.blank?
        errors.add(:user, "该用户账号已经被其他教师或者学生绑定")
      end
    end
  end

  accepts_nested_attributes_for :user

  after_save :destroy_homework_assigns_after_remove
  def destroy_homework_assigns_after_remove
    self.user.homework_assigns.destroy_all if self.is_removed?
  end

  after_save :destroy_team_student_after_remove
  def destroy_team_student_after_remove
    self.user.team_student.destroy if self.is_removed?
  end

  def self.import_from_csv(file)
    ActiveRecord::Base.transaction do
      parse_csv_file(file) do |row,index|
        student = Student.new(
          :real_name => row[0], :sid => row[1],
          :user_attributes => {
            :name => row[2],
            :email => row[3],
            :password => row[4],
            :password_confirmation => row[4]
          })
        if !student.save
          message = student.errors.first[1]
          raise "第 #{index+1} 行解析出错,可能的错误原因 #{message} ,请修改后重新导入"
        end
      end
    end
  end

  module UserMethods
    def self.included(base)
      base.has_one :student
      base.send(:include,InstanceMethod)
    end
    
    module InstanceMethod
      def is_student?
        role? "student"
      end
    end
  end

  include ModelRemovable
  include Paginated

  define_index do
    indexes real_name, :sortable => true

    where('is_removed = 0')
  end
end