class GnugkSqlacctUnregisterquery < ActiveRecord::Migration
  def up
    execute <<-__EOI
DROP FUNCTION IF EXISTS gnugk_sqlacct_unregisterquery( text, text, text, text, text, text );
CREATE FUNCTION gnugk_sqlacct_unregisterquery( text, text, text, text, text, text ) RETURNS void AS $$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my @args = @_;
  my $fields = [ 'g', 'u', 'endpoint-ip', 'endpoint-port', 'epid', 'aliases' ];
  my $params={};
  foreach my $field (@{$fields}) {
    $params->{$field}=shift(@args);
  }

  my $uri = 'http://localhost:9292/gnugk/SQLAcct/UnregisterQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( $params ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlacct_unregisterquery/1.0 ");

  my $response = $ua->request( $req );
  return undef;

$$ LANGUAGE plperlu;
__EOI
  end
end
