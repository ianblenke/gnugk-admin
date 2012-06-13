class GnugkSqlauthRegquery < ActiveRecord::Migration
  def up
    execute <<-__EOI
DROP FUNCTION IF EXISTS gnugk_sqlauth_regquery( text, text, text, text, text );
DROP TYPE IF EXISTS gnugk_sqlauth_regquery_type;
CREATE TYPE gnugk_sqlauth_regquery_type AS (result integer, aliases text, billingmode text, creditamount text);
CREATE FUNCTION gnugk_sqlauth_regquery( text, text, text, text, text ) RETURNS SETOF gnugk_sqlauth_regquery_type AS $$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my @args = @_;
  my $fields = [ 'g','gkip','u','callerip','alias' ];
  my $uri = 'http://localhost:9292/gnugk/SQLAuth/RegQuery';
  my $params={};
  foreach my $field (@{$fields}) {
    $params->{$field}=shift(@args);
  }

  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( $params ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlauth_regquery/1.0 ");

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
