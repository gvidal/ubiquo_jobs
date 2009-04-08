module UbiquoWorker

  class Worker
    attr_accessor :name, :sleep_time, :shutdown

    def initialize(name, sleep_time) 
      raise ArgumentError, "A worker name is required" if name.blank?
      self.name = name
      self.sleep_time = sleep_time
      self.shutdown = false
    end

    def run!
      while (!shutdown) do
        job = UbiquoJobs.manager.get(name)
        if job
          puts "#{Time.now} - executing job #{job.id}"
          job.run!
        else
          puts "#{Time.now} - no job available"
          sleep self.sleep_time
        end
      end
    end
        
  end  
end


