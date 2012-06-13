class GnugkSqlauthNbquery < ActiveRecord::Migration
  def up
    execute <<-__EOI
DROP FUNCTION IF EXISTS gnugk_sqlauth_nbquery( text, text, text, text, text, text, text, text, text );
DROP TYPE IF EXISTS gnugk_sqlauth_nbquery_type;
CREATE TYPE gnugk_sqlauth_nbquery_type AS ( destination text );
CREATE FUNCTION gnugk_sqlauth_nbquery( text, text, text, text, text, text, text, text, text ) RETURNS SETOF gnugk_sqlauth_nbquery_type AS $$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my @args = @_;
  my $fields = [ 'g','gkip','nbid','nbip','Calling-Station-Id','src-info',
                 'Called-Station-Id', 'dest-info','bandwidth' ];
  my $params={};
  foreach my $field (@{$fields}) {
    $params->{$field}=shift(@args);
  }

  my $uri = 'http://localhost:9292/gnugk/SQLAuth/NbQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( $params ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlauth_nbquery/1.0 ");

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
