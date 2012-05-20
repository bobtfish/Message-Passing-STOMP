use strict;
use warnings; 
# subscribe to messages from the queue 'foo'
use Net::Stomp;
my $stomp = Net::Stomp->new( { hostname => 'localhost', port => '6163' } );
$stomp->connect( { login => 'guest', passcode => 'guest' } );
$stomp->subscribe(
    {   destination             => '/queue/foo',
        'ack'                   => 'client',
        'activemq.prefetchSize' => 1
    }
);
while (1) {
  my $frame = $stomp->receive_frame;
  warn $frame->body; # do something here
  $stomp->ack( { frame => $frame } );
}
$stomp->disconnect;

