# frozen_string_literal: true

module Utilities
  extend ActiveSupport::Concern

  def render_error(resource)
    render partial: 'layouts/record_not_found', locals: { resource: resource }
  end

  def respond_to_block(path)
    respond_to do |format|
      format.html { redirect_to path }
      format.js
    end
  end
end
