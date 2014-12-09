#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "development"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
Dir.chdir(root)

require File.join(root, "config", "environment")

def send_all
  @schedule_entries = ScheduleEntry.all      #find_by_sent(false)   this is done in if statement later
  @schedule_entries.each do |t|
    if t.sent == false
      if t.time_to_send < Time.now.utc
       t.send_notify(t.participant.user, t.schedule_template_entries.questionnaire)
      end
    end	
  end		
end

$running = true
Signal.trap("TERM") do 
  $running = false
end

Rails.logger.auto_flushing = true if Rails.logger.respond_to?(:auto_flushing)

while $running do
  send_all
  sleep 1.hour
end
