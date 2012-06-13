class EventLog
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Versioning
  include Mongoid::Timestamps
#  include Mongoid::FullTextSearch
  store_in "event_logs", capped: true, size: 2_000_000_000, max: 100_000_000
  index :created_at

  field :channel
  field :data
#  fulltext_search_in :channel, :data_text, :index_name => 'channel_data'

  def data_text
    data.to_json
  end
end
