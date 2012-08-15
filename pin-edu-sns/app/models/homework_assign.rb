# -*- coding: utf-8 -*-
class HomeworkAssign < ActiveRecord::Base
  # --- 模型关联
  belongs_to :homework
  belongs_to :user
  belongs_to :student

  module UserMethods
    def self.included(base)
      base.has_many :homework_assigns
  
      # 学生所有被分配作业
      base.has_many :student_homeworks,
                    :through    => :homework_assigns,
                    :source     => :homework,
                    :through    => :homework_assigns
      
      # 学生未过期作业
      base.has_many :unexpired_student_homeworks,
                    :through    => :homework_assigns,
                    :source     => :homework,
                    :conditions => ['homeworks.deadline > ?', Time.now]

      # 学生已过期作业
      base.has_many :expired_student_homeworks,
                    :through    => :homework_assigns,
                    :source     => :homework,
                    :conditions => ['homeworks.deadline <= ?', Time.now]
    end
  end
end
