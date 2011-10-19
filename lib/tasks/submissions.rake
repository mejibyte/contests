namespace :submissions do
  desc "Looks at the last 50 submissions from the UVa Online Judge and creates local submissions accordingly."
  task :fetch => :environment do
    Uva::SubmissionFetcher.new.fetch
    LiveArchive::SubmissionFetcher.new.fetch
  end


  namespace :fetch do
    task :daemon => :environment do
      SubmissionFetcher.daemon
    end
  end
end

class SubmissionFetcher
  def self.daemon
    uva = Uva::SubmissionFetcher.new
    live_archive = LiveArchive::SubmissionFetcher.new
    puts "#{timestamp} Starting daemon to fetch submissions..."
    STDERR.puts "#{timestamp} Starting daemon to fetch submissions..."
    while true
      begin
        live_archive.fetch
        uva.fetch
        puts "#{timestamp} Sleeping 60 seconds before retrying..."
        sleep 60
      rescue => e
        puts "#{timestamp} Holy Macaroni! And exception was raised: #{e}"
        puts "#{timestamp} Retrying in 5 seconds, anyway."
        sleep 5
      end
    end
  end

  private 
  def self.timestamp
    "[#{Time.now}]"
  end
end