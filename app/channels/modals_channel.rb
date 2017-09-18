class ModalsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "modals"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
