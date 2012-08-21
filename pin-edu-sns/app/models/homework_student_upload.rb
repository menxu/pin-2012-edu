# -*- coding: utf-8 -*-
class HomeworkStudentUpload < ActiveRecord::Base
  # --- 模型关联
  belongs_to :creator,
             :class_name => 'User',
             :foreign_key => 'creator_id'

  belongs_to :homework_student_upload_requirement,
             :class_name => 'HomeworkRequirement',
             :foreign_key => 'requirement_id'

  belongs_to :file_entity
  belongs_to :homework

  include Comment::CommentableMethods
  # --- 给其他类扩展的方法
  module UserMethods
    def self.included(base)
      base.has_many :homework_student_uploads,
                    :class_name  => 'HomeworkStudentUpload',
                    :foreign_key => 'creator_id'

      base.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      # 学生上传作业提交物的数量
      # 参数 homework 是一个实例变量
      def uploaded_count_of_homework(homework)
        self.homework_student_uploads.where(:homework_id => homework.id).count
      end
    end
  end
end

