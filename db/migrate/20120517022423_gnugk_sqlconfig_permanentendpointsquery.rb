class GnugkSqlconfigPermanentendpointsquery < ActiveRecord::Migration
  def up
    execute <<-__EOI
DROP FUNCTION IF EXISTS gnugk_sqlconfig_permanentendpointsquery( text );
DROP TYPE IF EXISTS gnugk_sqlconfig_permanentendpointsquery_type;
CREATE TYPE gnugk_sqlconfig_permanentendpointsquery_type AS (section text, key text, value text);
CREATE FUNCTION gnugk_sqlconfig_permanentendpointsquery( text ) RETURNS SETOF gnugk_sqlconfig_permanentendpointsquery_type AS $$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my ($gkid) = @_; 

  my $uri = 'http://localhost:9292/gnugk/SQLConfig/PermanentEndpointsQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( { "gkid" => $gkid } ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlconfig_permanentendpointsquery/1.0 ");

  my $response = $ua->request( $req );
  my $body = $response->content;
  my $result = decode_json($body);
  foreach my $row (@{$result}) {
    return_next($row);
  }
  return undef;

$$ LANGUAGE plperlu;
__EOI
  end
end
