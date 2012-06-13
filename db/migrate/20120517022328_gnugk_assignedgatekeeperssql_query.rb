class GnugkAssignedgatekeeperssqlQuery < ActiveRecord::Migration
  def up
    execute <<-__EOI
DROP FUNCTION IF EXISTS gnugk_assignedgatekeeperssql_query( text, text, text, text );
DROP TYPE IF EXISTS gnugk_assignedgatekeeperssql_query_type;
CREATE TYPE gnugk_assignedgatekeeperssql_query_type AS (alias text);
CREATE FUNCTION gnugk_assignedgatekeeperssql_query( text, text, text, text ) RETURNS SETOF gnugk_assignedgatekeeperssql_query_type AS $$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my ($u, $i, $alias, $gkid) = @_; 

  my $uri = 'http://localhost:9292/gnugk/AssignedGatekeepersSQL/Query';
  my $params = encode_json( { "u" => $u, "i" => $i, "alias" => $alias, "gkid" => $gkid } );
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( $params );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_assignedgatekeeperssql_query/1.0 ");

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
