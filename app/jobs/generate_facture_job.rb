class GenerateFactureJob < ApplicationJob
  queue_as :default

  def perform(order)
    order.reservations.map(&:generate_code_png)
    order.generate_pdf
    TicketMailer.facture(order).deliver
    TicketMailer.ticketfacture(order).deliver
    order.update_column('issued',true)
  end
end