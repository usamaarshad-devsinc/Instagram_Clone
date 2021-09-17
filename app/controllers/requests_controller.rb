# frozen_string_literal: true

class RequestsController < ApplicationController
  def create
    recipient_id = params[:recipient_id]
    if already_followed?(recipient_id, current_account.id)
      delete_request
    else
      request = Request.new(recipient_id: recipient_id, sender_id: current_account.id)
      recipient = Account.find(recipient_id)
      request.status = recipient.is_private ? 'pending' : 'accepted'
      request.save!
    end
    redirect_to controller: :public, action: :profile, account: recipient_id
  end

  def update
    request = Request.find_by(id: params[:id])
    request.update(status: 'accepted') if request.status == 'pending'
    redirect_to root_path, notice: 'Request was successfuly accepted.'
  end

  def destroy
    Request.find_by(id: params[:id]).destroy
    redirect_to root_path, notice: 'Request was successfuly deleted.'
  end

  def toggle_privacy
    current_account.is_private = if params[:commit]
                                   true
                                 else
                                   false
                                 end
    current_account.save!
    redirect_to root_path, notice: 'Request was successfuly completed.'
  end

  private

  def delete_request(recipient_id)
    Request.where(recipient_id: recipient_id, sender_id: current_account.id).destroy
  end

  def already_followed?(recipient_id, sender_id)
    Request.exists?(recipient_id: recipient_id, sender_id: sender_id)
  end

  def send_mail(_user)
    respond_to do |format|
      UserMailer.with(user: @user).welcome_email.deliver_later
      format.html { redirect_to(@user, notice: 'User was successfully created.') }
      format.json { render json: @user, status: :created, location: @user }
    end
  end
end
