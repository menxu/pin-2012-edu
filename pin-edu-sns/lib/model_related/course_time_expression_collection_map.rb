class CourseTimeExpressionCollectionMap
  def initialize(course_teachers)
    @course_teachers = course_teachers
    @course_time_expressions = course_teachers.map do |course_teacher|
      course_teacher.course_time_expressions
    end.flatten

    @course_time_expression_collections = @course_time_expressions.group_by do |course_time_expression|
      course_time_expression.weekday_number_str
    end.values.map do |course_time_expressions|
      CourseTimeExpressionCollection.new(course_time_expressions)
    end.sort


    @line_course_time_expression_collections = @course_time_expression_collections.group_by do |course_time_expression_collection|
      course_time_expression_collection.weekday
    end.to_a.sort_by{|array|array[0]}

    @table_course_time_expression_collections = @course_time_expression_collections.group_by do |course_time_expression_collection|
      course_time_expression_collection.weekday_number_str
    end
    
    current_collection = CourseTimeExpressionCollection.new([CourseTimeExpression.get_by_time(Time.now)])
    @next_course_time_expression_collection = @course_time_expression_collections.select do |collection|
      collection >= current_collection
    end.first
    if @next_course_time_expression_collection.blank?
      @next_course_time_expression_collection = @course_time_expression_collections.first
    end

    @course_hours_count = @course_time_expressions.count
  end

  #[
  #  [weekday, [course_time_expression_collection1, course_time_expression_collection2]],
  #  [weekday, []],
  #]
  attr_reader :line_course_time_expression_collections

  attr_reader :next_course_time_expression_collection
  attr_reader :course_hours_count

  def find_by_weekday_and_number(weekday, number)
    arr = @table_course_time_expression_collections["#{weekday}_#{number}"]
    (arr || []).first
  end
end