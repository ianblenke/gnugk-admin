class GnugkGkpresencesqlQueryupdate < ActiveRecord::Migration
  def up
    execute <<-__EOI
DROP FUNCTION IF EXISTS gnugk_gkpresencesql_queryupdate( text, text );
CREATE FUNCTION gnugk_gkpresencesql_queryupdate( text, text ) RETURNS void AS $$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my ($b, $i) = @_; 

  my $uri = 'http://localhost:9292/gnugk/GkPresenceSQL/QueryUpdate';
  my $params = encode_json( { "b" => $b, "i" => $i });
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( $params );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_gkpresencesql_queryupdate/1.0 ");

  my $response = $ua->request( $req );
  my $body = $response->content;
  my $result = decode_json($body);
  return undef;

$$ LANGUAGE plperlu;
__EOI
  end
end
