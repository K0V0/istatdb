class LocalTaricController < ApplicationController

  	before_action :searcher, only: [:index, :search, :show]

  	def index

  	end

  	def new
  		@taricnum = LocalTaric.new
  	end

    def create
      @taricnum = LocalTaric.new(permitted_pars)
      if @taricnum.save
        redirect_to local_tarics_path
      else
        render "new"
      end
    end

  	private

  	def searcher
  		searcher_for autoshow:false
  	end

    def permitted_pars
      params[:local_taric].permit(:kncode, :description, :additional_info)
    end

end
