
require_relative 'Student_short'
require_relative 'Studend'
require_relative 'Student_list'
require_relative 'Data_storage_strategy'
require_relative '../DB/DB'


class Student_list_DB < DB

    def initialize (user, pass)
        super(user, pass)
        select_all_rows()
    end

    def select_all_rows()
        students = []
        array = select_from_table()
        array.each do |x|
            hash = {}
            hash[:id] = x[0]
            hash[:last_name] = x[1]
            hash[:first_name] = x[2]
            hash[:surname] = x[3]
            hash[:github] = x[4]
            hash[:phone] = x[5]
            hash[:mail] = x[6]
            students << Student.new(hash)
        end
        @array = array
    end
    
    attr_accessor :array

    def search_on_id(number)
        return @array.select(){|x| x.id == number}
      end
    
      def get_k_n_student_short_list(k, n, data_list = nil)
    
        raise "Нет такого количества объктов n" if n > @array.size()
        
        qty = (@array.size()/n).to_i
    
        raise "Нет такого количества страниц" if k > qty
    
        students_short = []
        for index in 0...n
          item = @array[(k-1)*n + index]
          if (item != nil) 
            std = Student_short.new(item) 
          else 
            next
          end
          std.id = index
          students_short << std
        end
    
        return Data_list_student_short.new(students_short)
    
      end
    
      def sort_by_lastname_and_initals()
        @array.sort_by{|x| x.last_name_and_initials}
      end
    
      def add_student(student)
        max_id = @array.max_by{|x| x.id}
        id = 0
        id = max_id 1 if !max_id
        
        student.id = id
        @array << student
      end
    
      def replace_student_by_id(id, student)
    
        @array.select{|x| x.id == id}.map{|x| x = student} 
    
      end
    
      def delete_student_by_id(id)
        @array.delete_if{|x| x.id == id}
      end
    
      def get_student_short_count()
        @array.size()
      end



    end