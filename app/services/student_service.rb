require 'httparty'

class StudentService
  BASE_URL = 'https://69126e4252a60f10c821a66b.mockapi.io/student_App'

  def self.fetch_students
    begin
      response = HTTParty.get(BASE_URL, headers: { 'Content-Type' => 'application/json' })
      
      if response.success?
        JSON.parse(response.body)
      else
        Rails.logger.error "Failed to fetch students: #{response.code} - #{response.message}"
        []
      end
    rescue StandardError => e
      Rails.logger.error "Error fetching students: #{e.message}"
      []
    end
  end

  def self.create_student(student_data)
    begin
      response = HTTParty.post(
        BASE_URL,
        headers: { 'Content-Type' => 'application/json' },
        body: student_data.to_json
      )
      
      if response.success?
        JSON.parse(response.body)
      else
        Rails.logger.error "Failed to create student: #{response.code} - #{response.message}"
        nil
      end
    rescue StandardError => e
      Rails.logger.error "Error creating student: #{e.message}"
      nil
    end
  end

  def self.delete_student(student_id)
    begin
      response = HTTParty.delete("#{BASE_URL}/#{student_id}")
      
      if response.success?
        true
      else
        Rails.logger.error "Failed to delete student: #{response.code} - #{response.message}"
        false
      end
    rescue StandardError => e
      Rails.logger.error "Error deleting student: #{e.message}"
      false
    end
  end
end