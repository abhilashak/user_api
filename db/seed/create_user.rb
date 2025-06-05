# frozen_string_literal: true

# Create a large number of users for performance testing
class CreateUser
  def initialize(count)
    @count = count
  end

  def run
    puts "Creating seed users..."

    # Create users with randomized data
    @count.times do |index|
      User.create!(
        name: "User #{index + 1}",
        biography: sample_biography_data.sample(3).join * 10
      )
      show_progress_indicator(index)
    end

    puts "\nCreated #{User.count} users successfully!"
  end

  private

  def sample_biography_data
    [
      "Full-stack developer with 5 years of experience in Ruby on Rails and React.",
      "DevOps engineer specializing in AWS and Kubernetes deployments.",
      "Senior software architect with a passion for scalable systems.",
      "Machine learning engineer focused on natural language processing.",
      "Mobile app developer with expertise in iOS and Android development.",
      "Backend developer specializing in high-performance APIs.",
      "Frontend specialist with deep knowledge of modern JavaScript frameworks.",
      "Database administrator with expertise in PostgreSQL optimization.",
      "Cloud architect with experience in multi-cloud environments.",
      "Security engineer focused on API and web application security."
    ]
  end

  def show_progress_indicator(user_index)
    print "." if (user_index + 1) % 100 == 0
  end
end
