File.open( File.expand_path('../../config.yml', __FILE__) ) do |yf|
  $GNUGK_STATIC_CONFIG=YAML::load( yf )
end
File.open( File.expand_path('../../docs.yml', __FILE__) ) do |yf|
  $GNUGK_DOCS=YAML::load( yf )
end
