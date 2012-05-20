use strict;
use warnings;
# send a message to the queue 'foo'
use Net::Stomp;
my $stomp = Net::Stomp->new( { hostname => 'localhost', port => '6163' } );
$stomp->connect( { login => 'guest', passcode => 'guest' } );
$stomp->send(
    { destination => '/queue/foo', body => '{"message":"test message"}' } );
$stomp->disconnect;

warn "MOO";

