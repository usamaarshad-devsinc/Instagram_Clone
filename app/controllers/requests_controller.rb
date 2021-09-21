# frozen_string_literal: true

class RequestsController < ApplicationController
  before_action :load_request, only: %i[update destroy]
  def create
    recipient_id = params[:recipient_id]
    generate_request(recipient_id)
    respond_to do |format|
      format.html { redirect_to profile_path(account: recipient_id) }
      format.js
    end
  end

  def update
    @request.update(status: 'accepted') if @request.status == 'pending'
    flash[:notice] = 'Request was successfuly accepted.'
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def destroy
    flash[:notice] = @request.destroy ? 'Request was successfuly deleted.' : @request.errors.full_messages
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  private

  def delete_request(recipient_id)
    Request.find_by(recipient_id: recipient_id, sender_id: current_account.id).destroy
  end

  def load_request
    @request = Request.find_by(id: params[:id])
  end

  def already_followed?(recipient_id)
    Request.exists?(recipient_id: recipient_id, sender_id: current_account.id)
  end

  def generate_request(recipient_id)
    @request = Request.new(recipient_id: recipient_id, sender_id: current_account.id)
    recipient = Account.find_by(id: recipient_id)
    @request.status = recipient.is_private ? 'pending' : 'accepted'
    flash[:notice] = @request.save ? 'Request sent!' : @request.errors.full_messages
  end

  def send_mail(_user)
    respond_to do |format|
      UserMailer.with(user: @user).welcome_email.deliver_later
      format.html { redirect_to(@user, notice: 'User was successfully created.') }
      format.json { render json: @user, status: :created, location: @user }
    end
  end
end
