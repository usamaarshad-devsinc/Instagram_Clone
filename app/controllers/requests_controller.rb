# frozen_string_literal: true

class RequestsController < ApplicationController
  before_action :set_request, only: %i[update destroy]

  def create
    recipient_id = params[:recipient_id]
    generate_request(recipient_id)
    respond_to do |format|
      format.html { redirect_to profile_path(account: recipient_id) }
      format.js
    end
  end

  def update
    authorize @request
    @request.update(status: 'accepted') if @request.status == 'pending'
    flash[:notice] = 'Request was successfuly accepted.'
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def destroy
    authorize @request
    flash[:notice] = @request.destroy ? 'Request was successfuly deleted.' : @request.errors.full_messages
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  private

  def delete_request(recipient_id)
    authorize @request, :destroy?
    Request.find_by(recipient_id: recipient_id, sender_id: current_account.id).destroy
  end

  def set_request
    @request = Request.find_by(id: params[:id])
  end

  def already_followed?(recipient_id)
    Request.exists?(recipient_id: recipient_id, sender_id: current_account.id)
  end

  def generate_request(recipient_id)
    @request = Request.new(recipient_id: recipient_id, sender_id: current_account.id)
    authorize @request, :create?
    recipient = Account.find_by(id: recipient_id)
    @request.status = recipient.is_private ? 'pending' : 'accepted'
    flash[:notice] = @request.save ? 'Request sent!' : @request.errors.full_messages
  end
end
