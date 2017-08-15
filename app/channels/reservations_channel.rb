# app/channels/reservations_channel.rb
class ReservationsChannel < ApplicationCable::Channel  
  def subscribed
    stream_from 'reservations'
  end
end  