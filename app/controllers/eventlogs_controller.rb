class EventlogsController < ApplicationController
  def search
  end
  # GET /eventlogs
  # GET /eventlogs.json
  def index
    if params[:q]
      @eventlogs = Kaminari.paginate_array(EventLog.fulltext_search(params[:q],
								    { :max_results => 20 })).page(params[:page])
    else
      @eventlogs = EventLog.desc(:created_at).page(params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @eventlogs }
    end
  end

  # GET /eventlogs/1
  # GET /eventlogs/1.json
  def show
    @eventlog = EventLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @eventlog }
    end
  end

end
