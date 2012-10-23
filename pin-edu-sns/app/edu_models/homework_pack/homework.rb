# -*- coding: utf-8 -*-
class Homework < ActiveRecord::Base
  HOMEWORK_ATTACHMENTS_DIR = '/MINDPIN_MRS_DATA/attachments/homework_attachments'

  # --- 模型关联
  belongs_to :creator,
             :class_name => 'User',
             :foreign_key => 'creator_id'

  belongs_to :course

  has_many :homework_requirements
  accepts_nested_attributes_for :homework_requirements

  has_many :homework_assigns
  accepts_nested_attributes_for :homework_assigns

  has_many :assignees,
           :through => :homework_assigns,
           :source  => :user
  
  # 没有提交作业的学生
  has_many :not_submitted_students,
           :through => :homework_assigns,
           :source => :user,
           :conditions => ['homework_assigns.is_submit = ?', false]
  
  # 已经提交作业的学生
  has_many :submitted_students,
           :through => :homework_assigns,
           :source => :user,
           :conditions => ['homework_assigns.is_submit = ?', true]
  
  # 学生附件
  has_many :homework_student_uploads
  
  # 老师创建作业时上传的附件
  has_many :homework_teacher_attachments
  
  
  # --- 校验方法
  validates :title, :content, :presence => true
  validates :course, :presence => true
  
  def teacher_attachment_zip_path
    "#{self.class::HOMEWORK_ATTACHMENTS_DIR}/homework_teacher#{self.creator.id}_#{self.id}.zip"
  end

  def assign_record_of(student_user)
    student_user.homework_assigns.find_by_homework_id(self.id)
  end
  
  # 学生是否被分配
  def has_assigned_to?(student_user)
    !self.assign_record_of(student_user).blank?
  end
  
  def has_finished_by?(student_user)
    self.assign_record_of(student_user).has_finished
  end

  def set_finished_by!(student_user)
    self.assign_record_of(student_user).update_attribute :has_finished, true
  end

  def has_submitted_by?(student_user)
    self.assign_record_of(student_user).is_submit
  end

  def all_requirements_uploaded_by?(student_user)
    self.homework_requirements.count == self.uploaded_count_of(student_user)
  end

  def uploaded_count_of(student_user)
    self.homework_student_uploads.where('creator_id = ?', student_user.id).count
  end

  # 老师创建作业时生成的附件压缩包
  def build_teacher_attachments_zip(user)
    path = "#{HOMEWORK_ATTACHMENTS_DIR}/homework_teacher#{user.id}_#{self.id}.zip"
    Zip::ZipFile.open(path, Zip::ZipFile::CREATE) do |zip|
      self.homework_teacher_attachments.each do |attachment|
        unless zip.find_entry(attachment.name)
          zip.add(attachment.name, attachment.file_entity.attach.path)
        end
      end
    end
  end
  
  # 压缩学生提交的附件
  def build_student_uploads_zip(user)
    homework_id = self.id
    path = "#{HOMEWORK_ATTACHMENTS_DIR}/homework_student#{user.id}_#{self.id}.zip"
    Zip::ZipFile.open(path, Zip::ZipFile::CREATE) do |zip|
      self.homework_student_uploads.where(:creator_id => user.id).each do |upload|
        unless zip.find_entry(upload.name)
          zip.add(upload.name, upload.file_entity.attach.path)
        end
      end
    end
  end
  
  # 学生提交作业
  def set_submitted_by!(user, content = '')
    homework_assign = self.homework_assigns.find_by_user_id(user.id)
    homework_assign.content = content
    homework_assign.is_submit = true
    homework_assign.submitted_at = Time.now
    homework_assign.save
  end
  
  # --- 给其他类扩展的方法
  module UserMethods
    def self.included(base)
      base.has_many :teacher_homeworks,
                    :class_name  => 'Homework',
                    :foreign_key => :creator_id

      # 老师未过期作业
      base.has_many :expired_teacher_homeworks,
                    :class_name  => 'Homework',
                    :foreign_key => :creator_id,
                    :conditions  => ['deadline > ?', Time.now]
      
      # 老师已过期作业
      base.has_many :unexpired_teacher_homeworks,
                    :class_name  => 'Homework',
                    :foreign_key => :creator_id,
                    :conditions  => ['deadline <= ?', Time.now]
      
      base.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      def homeworks
        if self.is_teacher?
          teacher_homeworks
        elsif self.is_student?
          student_homeworks
        end
      end

      def unexpired_homeworks
        if self.is_teacher?
          unexpired_teacher_homeworks
        elsif self.is_student?
          unexpired_student_homeworks
        end
      end

      def expired_homeworks
        if self.is_teacher?
          expired_teacher_homeworks
        elsif self.is_student?
          expired_student_homeworks
        end
      end

    end
  end
  include HomeworkAssignRule::HomeworkMethods
  include Comment::CommentableMethods
end