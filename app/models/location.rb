class Location < ActiveRecord::Base
	has_many :durations
	validates_presence_of :name, :category

	def update_averages
        durations = self.durations.where('created_at >= ?', 2.hour.ago)
        if durations.length > 0
            sum = 0
            durations.each do |wait_time|
              sum += wait_time.duration
              end
            avg = sum/durations.length
            self.average_duration = avg
            self.latest_duration = self.durations.last.duration
            p avg
            self.save
        else
            self.average_duration = 0
            self.save
        end
	end

end
