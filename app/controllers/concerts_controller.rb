class ConcertsController < ApplicationController
  
  before_action :check_admin_authorization, except: [:index]

  def new
    @concert=Concert.new
    @concerts=Concert.all
  end

  def create
    @concert=Concert.create(concert_params)
    if @concert.save
      if @concert.unnumbered?

        0..@concert.number_of_seats.to_i.times do |i|

          s=Seat.new
          s.column=(i % @concert.number_of_seats.to_i)+1
          s.concert_id = @concert.id
          s.price=@concert.single_price
          s.save

        end

      else

        rows=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S"]
        0..475.times do |i|
          s=Seat.new

          s.row=rows[i/25]

          s.column=(i % 25)+1

          s.concert_id = @concert.id

          if i < 250
            s.price= @concert.cat_A_price
          else
            s.price= @concert.cat_B_price
          end

          s.save
        end
      end
      redirect_to @concert
    else
      render 'new'
    end
  end

  def update
  end

  def edit
    @concerts=Concert.all
  end

  def delete
  end

  def destroy
  end

  def index
    @concerts=Concert.all.order("concerts.date")
  end

  def show
    @concerts=Concert.all.order("concerts.date")
  end

  private

    def concert_params
      params.require(:concert).permit(:name, :shortname, :date, :location, :cat_A_price, :cat_B_price, :image, :unnumbered, :number_of_seats,:single_price,:footnote,:subline)
    end

    def check_admin_authorization
      if user_signed_in?
        redirect_to root_path unless current_user.admin?
      else
        redirect_to root_path
      end
    end

end
