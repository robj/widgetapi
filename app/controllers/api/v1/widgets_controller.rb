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


end
