class StoryExpiresJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts "...................Story expires with id: #{args[0].class}"
    if Story.exists?(args[0])
        Story.destroy(args[0])
    end
  end
end
