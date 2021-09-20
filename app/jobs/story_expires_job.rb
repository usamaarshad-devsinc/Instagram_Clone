# frozen_string_literal: true

class StoryExpiresJob < ApplicationJob
  queue_as :default

  def perform(id)
    Rails.logger.debug "...................Story expires with id: #{id}"
    Story.destroy(id) if Story.exists?(id)
  end
end
