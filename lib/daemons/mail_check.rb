#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "production"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
Dir.chdir(root)

require File.join(root, "config", "environment")

def send_all
  @schedule_entries = ScheduleEntry.where(:sent => false)
  @schedule_entries.each do |schedule_entry|
    if schedule_entry.time_to_send < Time.now.utc
     UserMailer.notify(schedule_entry).deliver
     schedule_entry.sent = true
     schedule_entry.save
    end	
  end		
end

$running = true
Signal.trap("TERM") do 
  $running = false
end

Rails.logger.auto_flushing = true if Rails.logger.respond_to?(:auto_flushing)

sleep_count = 0
while $running do
  if sleep_count % 360 == 0
    send_all
    sleep_count = 0
  end
  sleep_count += 1
  sleep 10.seconds
end
