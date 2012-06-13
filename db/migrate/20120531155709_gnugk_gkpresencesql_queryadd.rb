class GnugkGkpresencesqlQueryadd < ActiveRecord::Migration
  def up
    execute <<-__EOI
DROP FUNCTION IF EXISTS gnugk_gkpresencesql_queryadd( text, text );
DROP TYPE IF EXISTS gnugk_gkpresencesql_queryadd_type;
CREATE TYPE gnugk_gkpresencesql_queryadd_type AS (subscriptionID text, h323id text, alias text, isSubscriber text, display text);
CREATE FUNCTION gnugk_gkpresencesql_queryadd( text, text ) RETURNS SETOF gnugk_gkpresencesql_queryadd_type AS $$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my ($i, $u, $a, $s, $d) = @_; 

  my $uri = 'http://localhost:9292/gnugk/GkPresenceSQL/QueryAdd';
  my $params = encode_json( { "i" => $i, "u" => $u, "a" => $a, "s" => $s, "d" => $d });
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( $params );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_gkpresencesql_queryadd/1.0 ");

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
