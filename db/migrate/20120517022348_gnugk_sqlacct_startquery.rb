class GnugkSqlacctStartquery < ActiveRecord::Migration
  def up
    execute <<-__EOI
DROP FUNCTION IF EXISTS gnugk_sqlacct_startquery( text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text );
CREATE FUNCTION gnugk_sqlacct_startquery( text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text ) RETURNS void AS $$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my @args = @_;
  my $fields = [ 'g', 'n', 'd', 't', 'c', 'cause-translated', 'r', 'p', 's', 'u', 'gkip', 'CallId', 'ConfId', 'CallLink', 'setup-time', 'alerting-time', 'connect-time', 'disconnect-time', 'ring-time', 'caller-ip', 'caller-port', 'callee-ip', 'callee-port', 'src-info', 'dest-info', 'Calling-Station-Id', 'Called-Station-Id', 'Dialed-Number', 'caller-epid', 'callee-epid', 'call-attempts', 'last-cdr', 'media-oip', 'codec', 'bandwidth', 'client-auth-id' ];
  my $params={};
  foreach my $field (@{$fields}) {
    $params->{$field}=shift(@args);
  }

  my $uri = 'http://localhost:9292/gnugk/SQLAcct/StartQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( $params ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlacct_startquery/1.0 ");

  my $response = $ua->request( $req );
  return undef;

$$ LANGUAGE plperlu;
__EOI
  end
end
