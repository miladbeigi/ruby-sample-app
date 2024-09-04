class HomeController < ApplicationController
    def index
      date = Time.now
      random = SecureRandom.hex(10)
      render json: { "Message": "Welcome #{random}", "Date": date }
    end

    def numbers
      count = params[:count]
      size = params[:size].to_i
      date = Time.now
      random1 = SecureRandom.hex(10)
      random2= random1.ljust(size, "0")
      count.to_i.times do
        HomeJob.perform_later(random2, date)
        Rails.logger.info("#{count} jobs queued on #{date}")
      end
      render json: { "Message": "Welcome #{random1}", "Date": date, "#Jobs": count.to_i, "Size": size }
    end
end
