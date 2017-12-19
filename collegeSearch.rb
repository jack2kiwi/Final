require "./College"
require "./scan"

def main()
  colleges = []
  f = File.open("MOCK_DATA.csv", "r")
  i = 0
  f.each_line { |line|

    fields = line.split(',')

    name = fields[0].strip
    average_gpa = fields[1].strip.to_f
    average_act = fields[2].strip.to_f
    acceptance_rate = fields[3].strip.to_f

    c = College.new(name, average_gpa, average_act, acceptance_rate, i)
    colleges.push(c)
    i = i + 1
  }

  puts "Here is a list of colleges:"
  print_colleges(colleges)

  puts "\n Input your gpa to give a better representation of your acceptance chance:"
  gpa = scan.to_f
  # while gpa % 0.0001 != 0
  #   puts "Not a valid input, try again"
  #   gpa = scan.to_f
  # end

  puts "\n Input your act:"
  act = scan.to_f
  # while act % 1 != 0
  #   puts "Not a valid input, try again"
  #   new_act = scan.to_f
  # end

  calculate_all_acceptance_chance(colleges, gpa, act)
  sort_by_acceptance(colleges)
  puts "\n Here are the colleges sorted by your acceptance chance:"
  puts "\n"
  print_colleges(colleges)
  loop(colleges, gpa, act)
end

def calculate_all_acceptance_chance(colleges, gpa, act)
  colleges.each do |college|
    college.calculate_acceptance_chance(gpa, act)
  end
end

def sort_by_acceptance(colleges)
  colleges.sort_by! {|college| college.acceptance_chance}
end

def print_colleges(colleges)
  colleges.each do |college|
    college.print_college_info
  end
end

def loop(colleges, gpa, act)
  input = 1
  while input != 3
    puts "\n What would you like to do now:"
    puts "1. See college list again"
    puts "2. Select a college"
    puts "3. Exit"
    input = scan.to_i
    while input != 1 && input != 2 && input != 3
      puts "Not a valid input, try again"
      input = scan.to_i
    end
    if input == 1
      puts "\n Here are the colleges sorted by your acceptance chance:"
      puts "\n"
      print_colleges(colleges)
    elsif input == 2
      puts "\n Input the id number of the college you want to go to:"
      input_id = scan.to_i
      while college_by_id(colleges, input) == 0
        puts "Not a valid input, try again"
        input_id = scan.to_i
      end
      selected_college = college_by_id(colleges, input_id)
      puts "\n You have selected #{selected_college.name}"
      input2 = 1
      while input2 != 3
        puts "\n What would you like to do:"
        puts "1. See college information"
        puts "2. See how to increase your chance of acceptance"
        puts "3. Go back"
        input2 = scan.to_i
        while input != 1 && input != 2 && input != 3
          puts "Not a valid input, try again"
          input2 = scan.to_i
        end
        if input2 == 1
          puts "\n"
          selected_college.see_information
        elsif input2 == 2
          selected_college.increase_acceptance_chances(gpa, act)
        end
      end
    elsif input == 3
      puts "\n Goodbye"
    end
  end
end

def college_by_id(colleges, id)
  colleges.each do |college|
    if college.id == id
      return college
    end
  end
  return 0
end

main
