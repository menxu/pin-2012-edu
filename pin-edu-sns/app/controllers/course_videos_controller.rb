# -*- coding: utf-8 -*-
class CourseVideosController < ApplicationController
  before_filter :login_required

  def create
    CourseVideo.create :file_entity_id => params[:file_entity_id], :course_id => params[:course_id], :name => params[:name], :creator => current_user
    render :text => '视频上传成功'
  end

  def destroy
    CourseVideo.find(params[:id]).destroy
    render :text => '视频已删除'
  end

  def show
    @resource = CourseVideo.find(params[:id])
    render :template => 'courses/resource_show'
  end

end