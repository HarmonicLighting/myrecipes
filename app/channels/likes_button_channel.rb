class LikesButtonChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_chef
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
