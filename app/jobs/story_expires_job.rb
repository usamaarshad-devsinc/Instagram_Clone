class StoryExpiresJob < ApplicationJob
  queue_as :default

  def perform(id)
    puts "...................Story expires with id: #{id}"
    if Story.exists?(id)
        Story.destroy(id)
    end
  end
end
