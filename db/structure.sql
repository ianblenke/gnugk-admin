--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plperlu; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plperlu WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plperlu; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plperlu IS 'PL/PerlU untrusted procedural language';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: gnugk_alternategatekeeperssql_query_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_alternategatekeeperssql_query_type AS (
	gatekeeper text
);


--
-- Name: gnugk_assignedaliasessql_query_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_assignedaliasessql_query_type AS (
	alias text
);


--
-- Name: gnugk_assignedgatekeeperssql_query_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_assignedgatekeeperssql_query_type AS (
	alias text
);


--
-- Name: gnugk_gkpresencesql_queryadd_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_gkpresencesql_queryadd_type AS (
	subscriptionid text,
	h323id text,
	alias text,
	issubscriber text,
	display text
);


--
-- Name: gnugk_gkpresencesql_querylist_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_gkpresencesql_querylist_type AS (
	subscriptionid text,
	h323id text,
	alias text,
	issubscriber text,
	status text,
	active text,
	updated text,
	display text
);


--
-- Name: gnugk_routingsql_query_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_routingsql_query_type AS (
	destination text
);


--
-- Name: gnugk_sqlaliasauth_query_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_sqlaliasauth_query_type AS (
	aliasrule text
);


--
-- Name: gnugk_sqlauth_callquery_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_sqlauth_callquery_type AS (
	result integer,
	billingmode integer,
	creditamount text,
	credittime integer,
	redirectnumber text,
	redirectip text,
	proxy text,
	clientauthid bigint,
	q931cause integer
);


--
-- Name: gnugk_sqlauth_nbquery_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_sqlauth_nbquery_type AS (
	destination text
);


--
-- Name: gnugk_sqlauth_regquery_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_sqlauth_regquery_type AS (
	result integer,
	aliases text,
	billingmode text,
	creditamount text
);


--
-- Name: gnugk_sqlconfig_assignedaliasquery_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_sqlconfig_assignedaliasquery_type AS (
	section text,
	key text,
	value text
);


--
-- Name: gnugk_sqlconfig_configquery_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_sqlconfig_configquery_type AS (
	section text,
	key text,
	value text
);


--
-- Name: gnugk_sqlconfig_gwprefixesquery_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_sqlconfig_gwprefixesquery_type AS (
	section text,
	key text,
	value text
);


--
-- Name: gnugk_sqlconfig_neighborsquery_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_sqlconfig_neighborsquery_type AS (
	section text,
	key text,
	value text
);


--
-- Name: gnugk_sqlconfig_permanentendpointsquery_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_sqlconfig_permanentendpointsquery_type AS (
	section text,
	key text,
	value text
);


--
-- Name: gnugk_sqlconfig_rewritealiasquery_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_sqlconfig_rewritealiasquery_type AS (
	section text,
	key text,
	value text
);


--
-- Name: gnugk_sqlconfig_rewritee164query_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_sqlconfig_rewritee164query_type AS (
	section text,
	key text,
	value text
);


--
-- Name: gnugk_sqlpasswordauth_query_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gnugk_sqlpasswordauth_query_type AS (
	password text
);


--
-- Name: gnugk_alternategatekeeperssql_query(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_alternategatekeeperssql_query(text, text, text) RETURNS SETOF gnugk_alternategatekeeperssql_query_type
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my ($i, $alias, $gkid) = @_; 

  my $uri = 'http://localhost:9292/gnugk/AlternateGatekeepersSQL/Query';
  my $params = encode_json( { "i" => $i, "alias" => $alias, "gkid" => $gkid });
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( $params );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_alternategatekeeperssql_query/1.0 ");

  my $response = $ua->request( $req );
  my $body = $response->content;
  my $result = decode_json($body);
  foreach my $row (@{$result}) {
    return_next($row);
  }
  return undef;

$_$;


--
-- Name: gnugk_assignedaliasessql_query(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_assignedaliasessql_query(text, text) RETURNS SETOF gnugk_assignedaliasessql_query_type
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my ($alias, $gk) = @_; 

  my $uri = 'http://localhost:9292/gnugk/AssignedAliasesSQL/Query';
  my $params = encode_json( { "alias" => $alias, "gk" => $gk });
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( $params );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_assignedaliasessql_query/1.0 ");

  my $response = $ua->request( $req );
  my $body = $response->content;
  my $result = decode_json($body);
  foreach my $row (@{$result}) {
    return_next($row);
  }
  return undef;

$_$;


--
-- Name: gnugk_assignedgatekeeperssql_query(text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_assignedgatekeeperssql_query(text, text, text, text) RETURNS SETOF gnugk_assignedgatekeeperssql_query_type
    LANGUAGE plperlu
    AS $_$

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

$_$;


--
-- Name: gnugk_gkpresencesql_queryadd(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_gkpresencesql_queryadd(text, text) RETURNS SETOF gnugk_gkpresencesql_queryadd_type
    LANGUAGE plperlu
    AS $_$

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

$_$;


--
-- Name: gnugk_gkpresencesql_querydelete(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_gkpresencesql_querydelete(text) RETURNS void
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my ($i) = @_; 

  my $uri = 'http://localhost:9292/gnugk/GkPresenceSQL/QueryDelete';
  my $params = encode_json( { "i" => $i });
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( $params );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_gkpresencesql_querydelete/1.0 ");

  my $response = $ua->request( $req );
  my $body = $response->content;
  my $result = decode_json($body);
  return undef;

$_$;


--
-- Name: gnugk_gkpresencesql_querylist(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_gkpresencesql_querylist(text, text) RETURNS SETOF gnugk_gkpresencesql_querylist_type
    LANGUAGE plperlu
    AS $_$

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

$_$;


--
-- Name: gnugk_gkpresencesql_queryupdate(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_gkpresencesql_queryupdate(text, text) RETURNS void
    LANGUAGE plperlu
    AS $_$

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

$_$;


--
-- Name: gnugk_gkqosmonitor_query(text, text, text, text, text, text, text, text, text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_gkqosmonitor_query(text, text, text, text, text, text, text, text, text, text, text, text, text, text) RETURNS void
    LANGUAGE plperlu
    AS $_$

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

$_$;


--
-- Name: gnugk_routingsql_query(text, text, text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_routingsql_query(text, text, text, text, text, text, text, text) RETURNS SETOF gnugk_routingsql_query_type
    LANGUAGE plperlu
    AS $_$

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

$_$;


--
-- Name: gnugk_sqlacct_alertquery(text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlacct_alertquery(text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text) RETURNS void
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my @args = @_;
  my $fields = [ 'g', 'n', 'd', 't', 'c', 'cause-translated', 'r', 'p', 's', 'u', 'gkip', 'CallId', 'ConfId', 'CallLink', 'setup-time', 'alerting-time', 'connect-time', 'disconnect-time', 'ring-time', 'caller-ip', 'caller-port', 'callee-ip', 'callee-port', 'src-info', 'dest-info', 'Calling-Station-Id', 'Called-Station-Id', 'Dialed-Number', 'caller-epid', 'callee-epid', 'call-attempts', 'last-cdr', 'media-oip', 'codec', 'bandwidth', 'client-auth-id' ];
  my $params={};
  foreach my $field (@{$fields}) {
    $params->{$field}=shift(@args);
  }

  my $uri = 'http://localhost:9292/gnugk/SQLAcct/AlertQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( $params ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlacct_alertquery/1.0 ");

  my $response = $ua->request( $req );
  my $body = $response->content;
  my $result = decode_json($body);
  return undef;

$_$;


--
-- Name: gnugk_sqlacct_offquery(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlacct_offquery() RETURNS void
    LANGUAGE plperlu
    AS $_$

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

$_$;


--
-- Name: gnugk_sqlacct_onquery(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlacct_onquery() RETURNS void
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my $uri = 'http://localhost:9292/gnugk/SQLAcct/OnQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( "" );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlacct_onquery/1.0 ");

  my $response = $ua->request( $req );
  return undef;

$_$;


--
-- Name: gnugk_sqlacct_registerquery(text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlacct_registerquery(text, text, text, text, text, text) RETURNS void
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my @args = @_;
  my $fields = [ 'g', 'u', 'endpoint-ip', 'endpoint-port', 'epid', 'aliases' ];
  my $params={};
  foreach my $field (@{$fields}) {
    $params->{$field}=shift(@args);
  }

  my $uri = 'http://localhost:9292/gnugk/SQLAcct/RegisterQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( $params ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlacct_registerquery/1.0 ");

  my $response = $ua->request( $req );
  return undef;

$_$;


--
-- Name: gnugk_sqlacct_startquery(text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlacct_startquery(text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text) RETURNS void
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my @args = @_;
  my $fields = [ 'g', 'n', 'd', 't', 'c', 'cause-translated', 'r', 'p', 's', 'u', 'gkip', 'CallId', 'ConfId', 'CallLink', 'setup-time', 'alerting-time', 'connect-time', 'disconnect-time', 'ring-time', 'caller-ip', 'caller-port', 'callee-ip', 'callee-port', 'src-info', 'dest-info', 'Calling-Station-Id', 'Called-Station-Id', 'Dialed-Number', 'caller-epid', 'callee-epid', 'call-attempts', 'last-cdr', 'media-oip', 'codec', 'bandwidth', 'client-auth-id' ];
  my $params={};
  foreach my $field (@{$fields}) {
    $params->{$field}=shift(@args);
  }

  my $uri = 'http://localhost:9292/gnugk/SQLAcct/StartQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( $params ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlacct_startquery/1.0 ");

  my $response = $ua->request( $req );
  return undef;

$_$;


--
-- Name: gnugk_sqlacct_stopquery(text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlacct_stopquery(text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text) RETURNS void
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my @args = @_;
  my $fields = [ 'g', 'n', 'd', 't', 'c', 'cause-translated', 'r', 'p', 's', 'u', 'gkip', 'CallId', 'ConfId', 'CallLink', 'setup-time', 'alerting-time', 'connect-time', 'disconnect-time', 'ring-time', 'caller-ip', 'caller-port', 'callee-ip', 'callee-port', 'src-info', 'dest-info', 'Calling-Station-Id', 'Called-Station-Id', 'Dialed-Number', 'caller-epid', 'callee-epid', 'call-attempts', 'last-cdr', 'media-oip', 'codec', 'bandwidth', 'client-auth-id' ];
  my $params={};
  foreach my $field (@{$fields}) {
    $params->{$field}=shift(@args);
  }

  my $uri = 'http://localhost:9292/gnugk/SQLAcct/StopQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( $params ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlacct_stopquery/1.0 ");

  my $response = $ua->request( $req );
  my $body = $response->content;
  my $result = decode_json($body);
  return undef;

$_$;


--
-- Name: gnugk_sqlacct_unregisterquery(text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlacct_unregisterquery(text, text, text, text, text, text) RETURNS void
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my @args = @_;
  my $fields = [ 'g', 'u', 'endpoint-ip', 'endpoint-port', 'epid', 'aliases' ];
  my $params={};
  foreach my $field (@{$fields}) {
    $params->{$field}=shift(@args);
  }

  my $uri = 'http://localhost:9292/gnugk/SQLAcct/UnregisterQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( $params ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlacct_unregisterquery/1.0 ");

  my $response = $ua->request( $req );
  return undef;

$_$;


--
-- Name: gnugk_sqlacct_updatequery(text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlacct_updatequery(text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text) RETURNS void
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my @args = @_;
  my $fields = [ 'g', 'n', 'd', 't', 'c', 'cause-translated', 'r', 'p', 's', 'u', 'gkip', 'CallId', 'ConfId', 'CallLink', 'setup-time', 'alerting-time', 'connect-time', 'disconnect-time', 'ring-time', 'caller-ip', 'caller-port', 'callee-ip', 'callee-port', 'src-info', 'dest-info', 'Calling-Station-Id', 'Called-Station-Id', 'Dialed-Number', 'caller-epid', 'callee-epid', 'call-attempts', 'last-cdr', 'media-oip', 'codec', 'bandwidth', 'client-auth-id' ];
  my $params={};
  foreach my $field (@{$fields}) {
    $params->{$field}=shift(@args);
  }

  my $uri = 'http://localhost:9292/gnugk/SQLAcct/UpdateQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( $params ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlacct_updatequery/1.0 ");

  my $response = $ua->request( $req );
  return undef;

$_$;


--
-- Name: gnugk_sqlaliasauth_query(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlaliasauth_query(text, text) RETURNS SETOF gnugk_sqlaliasauth_query_type
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my ($alias, $gk) = @_; 
  my $uri = 'http://localhost:9292/gnugk/SQLAliasAuth/Query';
  my $params = encode_json( { "alias" => $alias, "gk" => $gk });
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( $params );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlaliasauth_query/1.0 ");

  my $response = $ua->request( $req );
  my $body = $response->content;
  my $result = decode_json($body);
  foreach my $row (@{$result}) {
    return_next($row);
  }
  return undef;

$_$;


--
-- Name: gnugk_sqlauth_callquery(text, text, text, text, text, text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlauth_callquery(text, text, text, text, text, text, text, text, text, text, text) RETURNS SETOF gnugk_sqlauth_callquery_type
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my @args = @_;
  my $fields = [ 'g','gkip','u','callerip','Calling-Station-Id','Called-Station-Id',
                 'Dialed-Number','CallId','bandwidth','answer','arq' ];
  my $params={};
  foreach my $field (@{$fields}) {
    $params->{$field}=shift(@args);
  }

  my $uri = 'http://localhost:9292/gnugk/SQLAuth/CallQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( $params ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlauth_callquery/1.0 ");

  my $response = $ua->request( $req );
  my $body = $response->content;
  my $result = decode_json($body);
  foreach my $row (@{$result}) {
    return_next($row);
  }
  return undef;

$_$;


--
-- Name: gnugk_sqlauth_nbquery(text, text, text, text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlauth_nbquery(text, text, text, text, text, text, text, text, text) RETURNS SETOF gnugk_sqlauth_nbquery_type
    LANGUAGE plperlu
    AS $_$

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

$_$;


--
-- Name: gnugk_sqlauth_regquery(text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlauth_regquery(text, text, text, text, text) RETURNS SETOF gnugk_sqlauth_regquery_type
    LANGUAGE plperlu
    AS $_$

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

$_$;


--
-- Name: gnugk_sqlconfig_assignedaliasquery(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlconfig_assignedaliasquery(text) RETURNS SETOF gnugk_sqlconfig_assignedaliasquery_type
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my ($gkid) = @_; 

  my $uri = 'http://localhost:9292/gnugk/SQLConfig/AssignedAliasQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( { "gkid" => $gkid } ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlconfig_assignedaliasquery/1.0 ");

  my $response = $ua->request( $req );
  my $body = $response->content;
  my $result = decode_json($body);
  foreach my $row (@{$result}) {
    return_next($row);
  }
  return undef;

$_$;


--
-- Name: gnugk_sqlconfig_configquery(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlconfig_configquery(text) RETURNS SETOF gnugk_sqlconfig_configquery_type
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my ($gkid) = @_; 

  my $uri = 'http://localhost:9292/gnugk/SQLConfig/ConfigQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( { "gkid" => $gkid } ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlconfig_configquery/1.0 ");

  my $response = $ua->request( $req );
  my $body = $response->content;
  my $result = decode_json($body);
  foreach my $row (@{$result}) {
    return_next($row);
  }
  return undef;

$_$;


--
-- Name: gnugk_sqlconfig_gwprefixesquery(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlconfig_gwprefixesquery(text) RETURNS SETOF gnugk_sqlconfig_gwprefixesquery_type
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my ($gkid) = @_; 

  my $uri = 'http://localhost:9292/gnugk/SQLConfig/GwPrefixesQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( { "gkid" => $gkid } ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlconfig_gwprefixesquery/1.0 ");

  my $response = $ua->request( $req );
  my $body = $response->content;
  my $result = decode_json($body);
  foreach my $row (@{$result}) {
    return_next($row);
  }
  return undef;

$_$;


--
-- Name: gnugk_sqlconfig_neighborsquery(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlconfig_neighborsquery(text) RETURNS SETOF gnugk_sqlconfig_neighborsquery_type
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my ($gkid) = @_; 

  my $uri = 'http://localhost:9292/gnugk/SQLConfig/NeighborsQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( { "gkid" => $gkid } ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlconfig_neighborsquery/1.0 ");

  my $response = $ua->request( $req );
  my $body = $response->content;
  my $result = decode_json($body);
  foreach my $row (@{$result}) {
    return_next($row);
  }
  return undef;

$_$;


--
-- Name: gnugk_sqlconfig_permanentendpointsquery(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlconfig_permanentendpointsquery(text) RETURNS SETOF gnugk_sqlconfig_permanentendpointsquery_type
    LANGUAGE plperlu
    AS $_$

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

$_$;


--
-- Name: gnugk_sqlconfig_rewritealiasquery(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlconfig_rewritealiasquery(text) RETURNS SETOF gnugk_sqlconfig_rewritealiasquery_type
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my ($gkid) = @_; 

  my $uri = 'http://localhost:9292/gnugk/SQLConfig/RewriteAliasQuery';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( { "gkid" => $gkid } ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlconfig_rewritealiasquery/1.0 ");

  my $response = $ua->request( $req );
  my $body = $response->content;
  my $result = decode_json($body);
  foreach my $row (@{$result}) {
    return_next($row);
  }
  return undef;

$_$;


--
-- Name: gnugk_sqlconfig_rewritee164query(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlconfig_rewritee164query(text) RETURNS SETOF gnugk_sqlconfig_rewritee164query_type
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my ($gkid) = @_; 

  my $uri = 'http://localhost:9292/gnugk/SQLConfig/RewriteE164Query';
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( encode_json( { "gkid" => $gkid } ) );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlconfig_rewritee164query/1.0 ");

  my $response = $ua->request( $req );
  my $body = $response->content;
  my $result = decode_json($body);
  foreach my $row (@{$result}) {
    return_next($row);
  }
  return undef;

$_$;


--
-- Name: gnugk_sqlpasswordauth_query(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gnugk_sqlpasswordauth_query(text, text) RETURNS SETOF gnugk_sqlpasswordauth_query_type
    LANGUAGE plperlu
    AS $_$

use strict;
use HTTP::Status;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use URI::URL;
use JSON;

  my $json = new JSON;

  my ($alias, $gk) = @_; 

  my $uri = 'http://localhost:9292/gnugk/SQLPasswordAuth/Query';
  my $params = encode_json( { "alias" => $alias, "gk" => $gk });
  my $req = HTTP::Request->new( 'POST', $uri );
  $req->header( 'Accept' => 'application/json' );
  $req->content( $params );
  my $ua = LWP::UserAgent->new;
  $ua->agent("gnugk_sqlpasswordauth_query/1.0 ");

  my $response = $ua->request( $req );
  my $body = $response->content;
  my $result = decode_json($body);
  foreach my $row (@{$result}) {
    return_next($row);
  }
  return undef;

$_$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: gkconfigs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE gkconfigs (
    id integer NOT NULL,
    gksection_id integer NOT NULL,
    key character varying(255) NOT NULL,
    value text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: gkconfigs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE gkconfigs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gkconfigs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE gkconfigs_id_seq OWNED BY gkconfigs.id;


--
-- Name: gksections; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE gksections (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: gksections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE gksections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gksections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE gksections_id_seq OWNED BY gksections.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    firstname character varying(255),
    lastname character varying(255),
    password character varying(255),
    username character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY gkconfigs ALTER COLUMN id SET DEFAULT nextval('gkconfigs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY gksections ALTER COLUMN id SET DEFAULT nextval('gksections_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: gkconfigs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY gkconfigs
    ADD CONSTRAINT gkconfigs_pkey PRIMARY KEY (id);


--
-- Name: gksections_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY gksections
    ADD CONSTRAINT gksections_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20120516000000');

INSERT INTO schema_migrations (version) VALUES ('20120516000001');

INSERT INTO schema_migrations (version) VALUES ('20120516000002');

INSERT INTO schema_migrations (version) VALUES ('20120517022322');

INSERT INTO schema_migrations (version) VALUES ('20120517022325');

INSERT INTO schema_migrations (version) VALUES ('20120517022328');

INSERT INTO schema_migrations (version) VALUES ('20120517022331');

INSERT INTO schema_migrations (version) VALUES ('20120517022333');

INSERT INTO schema_migrations (version) VALUES ('20120517022336');

INSERT INTO schema_migrations (version) VALUES ('20120517022339');

INSERT INTO schema_migrations (version) VALUES ('20120517022342');

INSERT INTO schema_migrations (version) VALUES ('20120517022345');

INSERT INTO schema_migrations (version) VALUES ('20120517022348');

INSERT INTO schema_migrations (version) VALUES ('20120517022351');

INSERT INTO schema_migrations (version) VALUES ('20120517022354');

INSERT INTO schema_migrations (version) VALUES ('20120517022357');

INSERT INTO schema_migrations (version) VALUES ('20120517022359');

INSERT INTO schema_migrations (version) VALUES ('20120517022403');

INSERT INTO schema_migrations (version) VALUES ('20120517022405');

INSERT INTO schema_migrations (version) VALUES ('20120517022408');

INSERT INTO schema_migrations (version) VALUES ('20120517022411');

INSERT INTO schema_migrations (version) VALUES ('20120517022414');

INSERT INTO schema_migrations (version) VALUES ('20120517022417');

INSERT INTO schema_migrations (version) VALUES ('20120517022420');

INSERT INTO schema_migrations (version) VALUES ('20120517022423');

INSERT INTO schema_migrations (version) VALUES ('20120517022426');

INSERT INTO schema_migrations (version) VALUES ('20120517022429');

INSERT INTO schema_migrations (version) VALUES ('20120517022432');

INSERT INTO schema_migrations (version) VALUES ('20120531155708');

INSERT INTO schema_migrations (version) VALUES ('20120531155709');

INSERT INTO schema_migrations (version) VALUES ('20120531155710');

INSERT INTO schema_migrations (version) VALUES ('20120531155711');