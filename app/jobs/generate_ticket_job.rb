class GenerateTicketJob < ApplicationJob
  queue_as :default

  def perform(order)
    order.reservations.map(&:generate_code_png)
    order.reservations.map(&:generate_pdf)
    TicketMailer.ticket(order).deliver
  end
end