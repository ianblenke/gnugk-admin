class GnugkGkqosmonitorQuery < ActiveRecord::Migration
  def up
    execute <<-__EOI
DROP FUNCTION IF EXISTS gnugk_gkqosmonitor_query( text, text, text, text, text, text, text, text, text, text, text, text, text, text );
CREATE FUNCTION gnugk_gkqosmonitor_query( text, text, text, text, text, text, text, text, text, text, text, text, text, text ) RETURNS void AS $$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my @args = @_;
  my $fields = [ 'g','ConfId','session','caller-ip','caller-port','caller-nat','callee-ip','callee-port','avgdelay','packetloss','packetloss-percent','avgjitter','bandwidth','t' ];
  my $params={};
  foreach my $field (@{$fields}) {
    $params->{$field}=shift(@args);
  }

  my $uri = 'http://localhost:9292/gnugk/GkQoSMonitor/Query';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( $params ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_gkqosmonitor_query/1.0 ");

  my $response = $ua->request( $req );
  return undef;

$$ LANGUAGE plperlu;
__EOI
  end
end
