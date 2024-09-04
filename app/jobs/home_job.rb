class HomeJob < ApplicationJob
  queue_as :default

  def perform(name, date)
    10.times do
      Math.sqrt(rand(1..1000000))
    end
    Rails.logger.info("Job done #{name} on #{date}")
  end
end
