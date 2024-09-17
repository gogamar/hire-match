# Clear existing data
Candidate.destroy_all
Company.destroy_all
User.destroy_all
Job.destroy_all
Like.destroy_all
Interview.destroy_all
Question.destroy_all

users_data = [
  { email: 'alice@example.com', password: 'password123', role: :candidate, name: 'Alice', surname: 'Johnson' },
  { email: 'bob@example.com', password: 'password123', role: :candidate, name: 'Bob', surname: 'Smith' },
  { email: 'charlie@example.com', password: 'password123', role: :candidate, name: 'Charlie', surname: 'Brown' },
  { email: 'techinnovations@example.com', password: 'password123', role: :company, name: 'Tech Innovations' },
  { email: 'creativesolutions@example.com', password: 'password123', role: :company, name: 'Creative Solutions' }
]

users_data.each do |user_data|
  user = User.find_or_create_by(email: user_data[:email]) do |u|
    u.password = user_data[:password]
    u.role = user_data[:role]
  end

  if user.candidate?
    candidate = Candidate.find_or_initialize_by(user: user)
    candidate.update(name: user_data[:name], surname: user_data[:surname])
  elsif user.company?
    company = Company.find_or_initialize_by(user: user)
    company.update(name: user_data[:name])
  end
end

# Define sample jobs with descriptions
jobs = [
  { title: 'Software Engineer', location: 'San Francisco, CA', description: 'Develop and maintain software applications, collaborate with cross-functional teams, and ensure high performance and responsiveness of applications.' },
  { title: 'Product Manager', location: 'New York, NY', description: 'Oversee product development from concept to launch, manage project timelines, and work closely with engineering and marketing teams to deliver successful products.' },
  { title: 'Data Scientist', location: 'Austin, TX', description: 'Analyze and interpret complex data sets, create data models, and develop actionable insights to help guide business decisions and strategies.' },
  { title: 'UX Designer', location: 'Remote', description: 'Design user-friendly interfaces and experiences, conduct user research, and collaborate with developers to ensure intuitive and engaging designs.' },
  { title: 'Marketing Specialist', location: 'Los Angeles, CA', description: 'Plan and execute marketing campaigns, analyze market trends, and develop strategies to increase brand awareness and drive customer engagement.' },
  { title: 'Sales Manager', location: 'Chicago, IL', description: 'Lead and manage the sales team, develop sales strategies, and build relationships with clients to drive revenue growth and achieve sales targets.' }
]

companies = Company.all

# Create jobs for each company
companies.each do |company|
  jobs.each do |job_attributes|
    company.jobs.create!(job_attributes)
  end
end

puts "Created #{Job.count} jobs"

candidates = Candidate.all

candidates.each do |candidate|
  random_job = Job.order('RANDOM()').first
  Like.create(candidate_id: candidate.id, job_id: random_job.id)
end

Like.first.update(match: true)
Like.last.update(match: true)

puts "Created #{Like.count} likes"

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
