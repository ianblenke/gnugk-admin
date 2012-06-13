class GnugkRoutingsqlQuery < ActiveRecord::Migration
  def up
    execute <<-__EOI
DROP FUNCTION IF EXISTS gnugk_routingsql_query( text, text, text, text, text, text, text, text );
DROP TYPE IF EXISTS gnugk_routingsql_query_type;
CREATE TYPE gnugk_routingsql_query_type AS (destination text);
CREATE FUNCTION gnugk_routingsql_query( text, text, text, text, text, text, text, text ) RETURNS SETOF gnugk_routingsql_query_type AS $$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my @args=@_;
  my $fields = [ 'c','p','s','r','Calling-Station-Id','i','m','client-auth-id' ];
  my $params={};
  foreach my $field (@{$fields}) {
    $params->{$field}=shift(@args);
  }

  my $uri = 'http://localhost:9292/gnugk/RoutingSQL/Query';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( $params ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_routingsql_query/1.0 ");

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
