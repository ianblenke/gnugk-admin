class GnugkController < ApplicationController
  respond_to :js, :json
  layout nil
  skip_before_filter :verify_authenticity_token
	  #:if => Proc.new { |c| c.request.format == 'application/json' }

  def sql
    puts "  Params: #{params.inspect}"
    @client ||= Faye::Client.new('http://localhost:9292/faye')
    @result=send("handle_#{params['section']}_#{params['key']}".to_sym, params)
    @result=[] if ! @result
    puts "  Returning: #{@result.inspect}"
    begin
      @client.publish "/sql/response", body: { request: params, result: @result }
      respond_with @result, :location => request.fullpath
    rescue => e
      puts "Error during processing: #{$!}"
      puts "Backtrace:\n\t#{e.backtrace.join("\n\t")}"
    end
  end

  def handle_SQLConfig_PermanentEndpointsQuery params
    # column at index 0 - permanent endpoint IP address
    # column at index 1 - permanent endpoint port number
    # column at index 2 - permanent endpoint alias
    # column at index 3 - optional permanent endpoint prefixes (comma separated)
    []
  end

  def handle_RewriteE164Query params
    []
  end

  def handle_RewriteAliasQuery params
    []
  end

  def handle_AlternateGatekeepersSQL params
    fields = [ 'i', 'alias', 'gkid' ]
    []
  end

  def handle_AssignedGatekeepersSQLQuery params
    fields = [ 'u', 'i', 'alias', 'gkid' ]
    []
  end

  def handle_NeighborsQuery params
    # column at index 0 - neighbor name (identifier)
    # column at index 1 - neighbor IP address
    # column at index 2 - neighbor port number
    # column at index 3 - optional prefixes (comma separated)
    # column at index 4 - optional password
    # column at index 5 - optional dynamic IP flag
    []
  end

  def handle_PermanentEndpointsQuery params
    # 4 columns in result set
    []
  end

  def handle_AssignedAliasesSQLQuery params
  end

  def handle_GkQosMonitorQuery params
    # fields = [ 'g','ConfId','session','caller-ip','caller-port','caller-nat','callee-ip','callee-port','avgdelay','packetloss','packetloss-percent','avgjitter','bandwidth','t' ]
    []
  end

  def handle_RoutingSQLQuery params
    # fields = [ 'c','p','s','r','Calling-Station-Id','i','m','client-auth-id' ]
    []
  end

  def handle_SQLAcctAlertQuery params
    # fields = ['g', 'n', 'd', 't', 'c', 'cause-translated', 'r', 'p', 's', 'u', 'gkip', 'CallId', 'ConfId', 'CallLink', 'setup-time', 'alerting-time', 'connect-time', 'disconnect-time', 'ring-time', 'caller-ip', 'caller-port', 'callee-ip', 'callee-port', 'src-info', 'dest-info', 'Calling-Station-Id', 'Called-Station-Id', 'Dialed-Number', 'caller-epid', 'callee-epid', 'call-attempts', 'last-cdr', 'media-oip', 'codec', 'bandwidth', 'client-auth-id' ]
    []
  end

  def handle_SQLAcctRegisterQuery params
    # fields = [ 'g', 'u', 'endpoint-ip', 'endpoint-port', 'epid', 'aliases' ]
    []
  end

  def handle_SQLAcctStartQuery params
    # fields  = [ 'g', 'n', 'd', 't', 'c', 'cause-translated', 'r', 'p', 's', 'u', 'gkip', 'CallId', 'ConfId', 'CallLink', 'setup-time', 'alerting-time', 'connect-time', 'disconnect-time', 'ring-time', 'caller-ip', 'caller-port', 'callee-ip', 'callee-port', 'src-info', 'dest-info', 'Calling-Station-Id', 'Called-Station-Id', 'Dialed-Number', 'caller-epid', 'callee-epid', 'call-attempts', 'last-cdr', 'media-oip', 'codec', 'bandwidth', 'client-auth-id' ]
    []
  end

  def handle_SQLAcctStopQuery params
    # fields = [ 'g', 'n', 'd', 't', 'c', 'cause-translated', 'r', 'p', 's', 'u', 'gkip', 'CallId', 'ConfId', 'CallLink', 'setup-time', 'alerting-time', 'connect-time', 'disconnect-time', 'ring-time', 'caller-ip', 'caller-port', 'callee-ip', 'callee-port', 'src-info', 'dest-info', 'Calling-Station-Id', 'Called-Station-Id', 'Dialed-Number', 'caller-epid', 'callee-epid', 'call-attempts', 'last-cdr', 'media-oip', 'codec', 'bandwidth', 'client-auth-id' ]
    []
  end

  def handle_SQLAcctUnregisterQuery params
    # fields = [ 'g', 'u', 'endpoint-ip', 'endpoint-port', 'epid', 'aliases' ]
    []
  end

  def handle_SQLAcctUpdateQuery params
    # fields = [ 'g', 'n', 'd', 't', 'c', 'cause-translated', 'r', 'p', 's', 'u', 'gkip', 'CallId', 'ConfId', 'CallLink', 'setup-time', 'alerting-time', 'connect-time', 'disconnect-time', 'ring-time', 'caller-ip', 'caller-port', 'callee-ip', 'callee-port', 'src-info', 'dest-info', 'Calling-Station-Id', 'Called-Station-Id', 'Dialed-Number', 'caller-epid', 'callee-epid', 'call-attempts', 'last-cdr', 'media-oip', 'codec', 'bandwidth', 'client-auth-id' ]
    []
  end

  def handle_SQLAliasAuthQuery params
    # fields = [ 'alias', 'gk' ]
    []
  end

  def handle_SQLAuthCallQuery params
    # fields = [ 'g','gkip','u','callerip','Calling-Station-Id','Called-Station-Id',
    []
  end

  def handle_SQLAuthNbQuery params
    # fields = [ 'g','gkip','nbid','nbip','Calling-Station-Id','src-info', 'Called-Station-Id', 'dest-info','bandwidth' ]
    []
  end

  def handle_SQLAuthRegQuery params
    # fields = [ 'g','gkip','u','callerip','alias' ];
    []
  end

  def handle_SQLConfig_AssignedAliasQuery params
    # fields = [ 'gkid' ]
    []
  end

  def handle_SQLConfig_ConfigQuery params
    # Params:
    #   gkid
    # Returns:
    #   section
    #   key
    #   value
    result=[]
    Gkconfig.all.each do |gkconfig|
      result.push( { section: gkconfig.section, key: gkconfig.key, value: gkconfig.value } )
    end
    result
  end

  def handle_SQLConfig_GwPrefixesQuery params
    # Params:
    #   gkid
    # Returns:
    #   section
    #   key
    #   value
    []
  end

  def handle_SQLConfig_NeighborsQuery params
    # Params:
    #   gkid
    # Returns:
    #   name     - neighbor name (identifier)
    #   ip       - neighbor IP address
    #   port     - neighbor port number
    #   prefixes - optional prefixes (comma separated)
    #   password - optional password
    #   dynamic  - optional dynamic IP flag
    []
  end


  # gnugk_sqlconfig_permanentendpointsquery.rb:  $req->content( encode_json( { "gkid" => $gkid } ) );
  # gnugk_sqlconfig_rewritealiasquery.rb:  $req->content( encode_json( { "gkid" => $gkid } ) );
  # gnugk_sqlconfig_rewritee164query.rb:  $req->content( encode_json( { "gkid" => $gkid } ) );
  # gnugk_sqlpasswordauth_query.rb:  my $params = encode_json( { "alias" => $alias, "gk" => $gk });
  # gnugk_gkpresencesql_querylist.rb:  my $params = encode_json( { "alias" => $alias, "gk" => $gk });
  # gnugk_gkpresencesql_queryadd.rb:  my $params = encode_json( { "i" => $i, "u" => $u, "a" => $a, "s" => $s, "d" => $d });
  # gnugk_gkpresencesql_querydelete.rb:  my $params = encode_json( { "i" => $i });
  # gnugk_gkpresencesql_queryupdate.rb:  my $params = encode_json( { "b" => $b, "i" => $i });
  #

end
