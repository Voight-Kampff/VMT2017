class OrdersController < ApplicationController
  def new
  end

  def create
    if @order.save
      session[:order_id] = @order.id
    end
  end

  def edit
  end

  def update
    @order = Order.find_by_id(session[:order_id])
    @order.update(order_params)
    @hypdf = HyPDF.htmltopdf(
    '<html><body><h1>Title</h1></body></html>',
    orientation: 'Portrait',
    bucket: 'variations',
    key: 'some_file_name.pdf',
    test: true,
    user_style_sheet: "/assets/application-c9cf7f792f2164813e4cf25b0b1c29f1f06fad52d4ec2d461fec4e5ff3a2cf51.css"
    # ... other options ...
    )
    send_data(
    @hypdf[:pdf],
    filename: "pdf_with_#{@hypdf[:pages]}_pages.pdf",
    type: 'application/pdf'
    )

  end

  def delete
  end

  def destroy
  end

  private
    
    def order_params
      params.require(:order).permit(:email,:title,:first_name,:last_name,:road,:telephone,:town,:postcode,:country)
    end

end
