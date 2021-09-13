class RequestsController < ApplicationController

  def create
    recipient_id = params[:recipient_id]
    request = Request.new(recipient_id: recipient_id, sender_id: current_account.id)
    recipient = Account.find(recipient_id)
    request.status = recipient.is_private ? 'pending' : 'accepted'
    puts request.inspect
    request.save
  end

  def update
    r = Request.find_by(id: params[:id])
    r.update(status: 'accepted') if r.status == 'pending'
    redirect_to controller: :public, action: :homepage, notice: 'Request was successfuly accepted.'
  end

  def destroy
    Request.find_by(id: params[:id]).destroy
    redirect_to controller: :public, action: :homepage, notice: 'Request was successfuly deleted.'
  end

  def delete_request
    puts params
  end

  def toggle_privacy
    if params[:commit]
      current_account.is_private = true
    else
      current_account.is_private = false
    end
    current_account.save!
    redirect_to controller: :public, action: :homepage, notice: 'Request was successfuly completed  .'
  end
end
