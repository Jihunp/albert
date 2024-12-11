class ActualReminderJob
	include Sidekiq::Job
	queue_as :default

	def perform (content, channel_key)
		ActionCable.server.broadcast(channel_key, content)
	end
end	
	