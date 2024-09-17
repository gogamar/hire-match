# Hire-match

**Hire-match** is a Ruby on Rails application that facilitates job matching between candidates and companies. The application allows candidates to browse job listings, save favorite jobs, and participate in interviews with responses powered by OpenAI. Companies can review job applications and track candidate matches based on mutual interest.

## Features

- **Authentication:** Users can log in as either a candidate or a company using Devise.
- **Candidate Functionality:**
  - View a list of job opportunities.
  - Save jobs as favorites by liking them.
  - Participate in interviews with a series of questions, where responses are generated by OpenAI.
- **Company Functionality:**
  - View job applications, including interview transcripts.
  - Like candidates who have previously liked the job.
  - View matches on the dashboard where mutual interests are displayed.

## Technologies Used

- **Ruby on Rails 3.2.0**
- **Devise:** For user authentication.
- **Pundit:** For authorization.
- **HTTParty:** For making HTTP requests.
- **Ruby-OpenAI:** For interacting with OpenAI’s API to generate interview responses.

## Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/yourusername/hire-match.git
   cd hire-match
   ```

2. **Install gems:**

   ```bash
   bundle install
   ```

3. **Set up the Database:**

   ```bash
   rake db:create
   rake db:migrate
   rake db:seed
   ```

4. **Configure Devise:**

```bash
   rails generate devise:install
```

5. **Configure OpenAI API:**

Set your OpenAI API key in your environment variables. You can do this by adding the following to your .env file or setting it directly on your hosting platform:

```bash
OPENAI_API_KEY=your_openai_api_key
```

Run the server

```bash
bin/dev
```

Navigate to http://localhost:3000 to view the application.
