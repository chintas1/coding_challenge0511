class Job
  attr_accessor :company_name, :job_title, :category, :city
  def initialize(company_name, job_title, category, city)
    @company_name = company_name
    @job_title = job_title
    @category = category
    @city = city 
  end
end