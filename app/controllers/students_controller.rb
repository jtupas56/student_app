class StudentsController < ApplicationController
  def index
    @students = StudentService.fetch_students
  end

  def create
    student_data = {
      student_Name: params[:name],
      student_Email: params[:email],
      student_Course: params[:course],
      student_Code: params[:code],
      student_Year: params[:year]
    }

    new_student = StudentService.create_student(student_data)
    
    if new_student
      redirect_to students_path, notice: 'Student added successfully!'
    else
      redirect_to students_path, alert: 'Failed to add student. Please try again.'
    end
  end

  def destroy
    if StudentService.delete_student(params[:id])
      redirect_to students_path, notice: 'Student deleted successfully!'
    else
      redirect_to students_path, alert: 'Failed to delete student. Please try again.'
    end
  end
end