class GnugkSqlacctOffquery < ActiveRecord::Migration
  def up
    execute <<-__EOI
DROP FUNCTION IF EXISTS gnugk_sqlacct_offquery();
CREATE FUNCTION gnugk_sqlacct_offquery() RETURNS void AS $$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my $uri = 'http://localhost:9292/gnugk/SQLAcct/OffQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( "" );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlacct_offquery/1.0 ");

  my $response = $ua->request( $req );
  return undef;

$$ LANGUAGE plperlu;
__EOI
  end
end
