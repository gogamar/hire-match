# Clear existing data
User.destroy_all
Job.destroy_all
Interview.destroy_all
Question.destroy_all

users = User.create!(
  [
    { email: 'alice@example.com', password: 'password123', role: :candidate },
    { email: 'bob@example.com', password: 'password123', role: :candidate },
    { email: 'charlie@example.com', password: 'password123', role: :candidate },
    { email: 'techinnovations@example.com', password: 'password123', role: :company },
    { email: 'creativesolutions@example.com', password: 'password123', role: :company }
  ]
)

puts "Created #{User.count} users"

users.each do |user|
  if user.candidate?
    candidate = Candidate.where(user: user).first_or_create!
    candidate.update!(name: Faker::Name.first_name, surname: Faker::Name.last_name)
  elsif user.company?
    company = Company.where(user: user).first_or_create!
    company.update!(name: Faker::Company.name)
  end
end

# Define sample jobs
jobs = [
  { title: 'Software Engineer', location: 'San Francisco, CA' },
  { title: 'Product Manager', location: 'New York, NY' },
  { title: 'Data Scientist', location: 'Austin, TX' },
  { title: 'UX Designer', location: 'Remote' },
  { title: 'Marketing Specialist', location: 'Los Angeles, CA' },
  { title: 'Sales Manager', location: 'Chicago, IL' }
]

companies = Company.all

# Create jobs for each company
companies.each do |company|
  jobs.each do |job_attributes|
    company.jobs.create!(job_attributes)
  end
end

candidates = Candidate.all

candidates.each do |candidate|
  candidate.jobs << Job.all.sample(rand(1..3))
end

puts "Created #{Job.count} jobs"

# Define sample questions
questions_for_interviews = [
  [
    "Can you describe a challenging project you have worked on and how you overcame the obstacles?",
    "What are your strategies for staying up-to-date with industry trends and advancements?",
    "How do you prioritize tasks and manage deadlines in a fast-paced work environment?",
    "Describe a time when you had to collaborate with a difficult team member. How did you handle it?"
  ],
  [
    "What motivates you to perform your best work?",
    "How do you handle feedback and criticism from colleagues or supervisors?",
    "Can you provide an example of a time when you improved a process or system at your previous job?",
    "What are your long-term career goals and how do you plan to achieve them?"
  ]
]

jobs = Job.all

jobs.each_with_index do |job, index|
  # Only one interview per job
  if job.interview.nil?
    interview = job.create_interview!(name: "Interview for #{job.title}")

    # for variation, use different set of questions for each interview
    questions = questions_for_interviews[index % questions_for_interviews.size]

    questions.each_with_index do |question_content, q_index|
      interview.questions.create!(content: question_content, number: q_index + 1)
    end
  end
end


puts "Created #{Interview.count} interviews"
puts "Created #{Question.count} questions"
