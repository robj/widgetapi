class Api::V1::WidgetsController < ApplicationController



    def index

        widgets = Widget.all
        render json: widgets

    end



    def show

        widget = Widget.find(params[:id])

        if widget
                
            render json: widget

        else

            head :not_found

        end

    end


    def create


        widget = Widget.new(widgets_params_create)

        if widget.save

            render json: widget

        else

            head :internal_server_error

        end


    end




    def update


        widget = Widget.find(params[:id])

        if widget.update_attributes(widgets_params_update)

            render json: widget

        else

            head :internal_server_error

        end




    end







private


  def widgets_params_create
    permitable_params = [:name, :supplier, :cost]
    params.require(:widget).permit(permitable_params)
  end

  def widgets_params_update
    permitable_params = [:supplier, :cost]
    params.require(:widget).permit(permitable_params)
  end



end
