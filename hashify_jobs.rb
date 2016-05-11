load 'job.rb'
require 'pry-byebug'

def generate_jobs
  company_names = ["Martha", "Citarella", "Acme", "Little Donkey"]
  job_titles = ["Busser", "Executive Chef", "Server", "Production Cook", "Host"]
  categories = ["Wine", "Restaurant", "Bar"]
  city = ["Cambridge", "Honolulu", "New York"]
  jobs = []
  100.times do
    jobs << Job.new(company_names.sample, job_titles.sample, categories.sample, city.sample)
  end
  jobs
end

# {category => {city => {company_name => [job_title]},...},...}
def hashify(jobs)
  jobs.each_with_object({}) do |job, jobs_hash|
    jobs_hash[job.category] ||= {}
    jobs_hash[job.category][job.city] ||= {}
    jobs_hash[job.category][job.city][job.company_name] ||= []
    jobs_hash[job.category][job.city][job.company_name] << job.job_title
  end
end

p hashify(generate_jobs)