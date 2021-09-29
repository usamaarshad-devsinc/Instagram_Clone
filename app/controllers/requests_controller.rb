# frozen_string_literal: true

class RequestsController < ApplicationController
  before_action :set_request, only: %i[update destroy]
  before_action :authorization, only: %i[update destroy]

  def create
    recipient_id = params[:recipient_id]
    generate_request(recipient_id)
    respond_to_block(profile_path(account: recipient_id))
  end

  def update
    @request.update(status: 'accepted') if @request.status == 'pending'
    flash[:notice] = 'Request was successfuly accepted.'
    respond_to_block(root_path)
  end

  def destroy
    flash[:notice] = @request.destroy ? 'Request was successfuly deleted.' : @request.errors.full_messages
    respond_to_block(root_path)
  end

  private

  def set_request
    @request = Request.find_by(id: params[:id])
    render_error('Request') if @request.nil?
  end

  def generate_request(recipient_id)
    @request = Request.new(recipient_id: recipient_id, sender_id: current_account.id)
    authorize @request, :create?
    recipient = Account.find_by(id: recipient_id)
    if recipient.nil?
      render_error('Account')
    else
      @request.status = recipient.is_private ? 'pending' : 'accepted'
      flash[:notice] = @request.save ? 'Request sent!' : @request.errors.full_messages
    end
  end

  def authorization
    authorize @request
  end
end
