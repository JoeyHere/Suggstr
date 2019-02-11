class TypesController < ApplicationController

    before_action :set_type, only: [:show]

    def show
    end

    private

    def set_type
      @type = Type.find(params[:id])
    end
end
