use strict;
use warnings;
use Test::More;

use AnyEvent;
use Log::Stash::Input::STOMP;
use Log::Stash::Output::Test;
use Log::Stash::Output::STOMP;
use JSON;

use Net::Stomp;
my $stomp = Net::Stomp->new( { hostname => 'localhost', port => '6163' } );
$stomp->connect( { login => 'guest', passcode => 'guest' } );
$stomp->subscribe(
    {   destination             => '/queue/foo',
        'ack'                   => 'client',
        'activemq.prefetchSize' => 1
    }
);

my $output = Log::Stash::Output::STOMP->new();
my $cv = AnyEvent->condvar;
my $timer; $timer = AnyEvent->timer(after => 1, cb => sub { undef $timer; $cv->send });
$cv->recv;
$output->consume({foo => 'bar'});
my $frame = $stomp->receive_frame;
$stomp->ack( { frame => $frame } );
$stomp->disconnect;

is_deeply(decode_json($frame->body), {foo => 'bar'});

done_testing;

