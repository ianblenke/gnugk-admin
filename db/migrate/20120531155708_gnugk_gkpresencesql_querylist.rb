class GnugkGkpresencesqlQuerylist < ActiveRecord::Migration
  def up
    execute <<-__EOI
DROP FUNCTION IF EXISTS gnugk_gkpresencesql_querylist( text, text );
DROP TYPE IF EXISTS gnugk_gkpresencesql_querylist_type;
CREATE TYPE gnugk_gkpresencesql_querylist_type AS (subscriptionID text, h323id text, alias text, isSubscriber text, status text, active text, updated text, display text);
CREATE FUNCTION gnugk_gkpresencesql_querylist( text, text ) RETURNS SETOF gnugk_gkpresencesql_querylist_type AS $$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my ($alias, $gk) = @_; 

  my $uri = 'http://localhost:9292/gnugk/GkPresenceSQL/QueryList';
  my $params = encode_json( { "alias" => $alias, "gk" => $gk });
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( $params );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_gkpresencesql_querylist/1.0 ");

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
