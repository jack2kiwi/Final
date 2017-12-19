require "./scan"

class College

  attr_accessor :name, :average_gpa, :average_act, :acceptance_rate, :acceptance_chance, :id

  def initialize(name, average_gpa, average_act, acceptance_rate, id)
    @name = name
    @average_gpa = average_gpa
    @average_act = average_act
    @acceptance_rate = acceptance_rate
    @acceptance_chance = acceptance_rate
    @id = id
  end

  def calculate_acceptance_chance(gpa, act)
    @acceptance_chance = recalculate_acceptance_chance(gpa, act)
  end

  def recalculate_acceptance_chance(gpa, act)
    gpa_difference = (1.00 * gpa / average_gpa)
    act_difference = (1.00 * act / average_act)
    new_chance = acceptance_rate * (gpa_difference ** 3) * (act_difference ** 3) / 2
    if new_chance >= 100.0
      new_chance = 99.99
    end
    return(new_chance)
  end

  def print_college_info
    puts "#{name}: #{acceptance_chance}%. Id = #{id}"
  end

  def increase_acceptance_chances(gpa, act)
    gpa_difference = (gpa / average_gpa)
    act_difference = (act / average_act)
    initial_chance = calculate_acceptance_chance(gpa, act)
    if gpa_difference > act_difference
      puts "You could best increase your chances of making it into #{name} by increasing your ACT score."

      puts "Type a new ACT score:"
      new_act = scan.to_f

      new_chance = recalculate_acceptance_chance(gpa, new_act)
      puts "By changing your ACT score from a #{act} to a #{new_act} your acceptance_chance would change from a #{initial_chance} to a #{new_chance}"
    else
      puts "You could best increase your chances of making it into #{name} by increasing your GPA."

      puts "Type a new GPA:"
      new_gpa = scan.to_f
      new_chance = recalculate_acceptance_chance(new_gpa, act)
      puts "By changing your GPA from a #{gpa} to a #{new_gpa} your acceptance_chance would change from a #{initial_chance} to a #{new_chance}"
    end
  end

  def see_information
    puts "#{name} has an average GPA of #{average_gpa}, an average ACT of #{average_act}, and an acceptacne rate of #{acceptance_rate}. Your chance of acceptance with current scores is #{acceptance_chance}%"
  end

end
