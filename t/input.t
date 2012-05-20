use strict;
use warnings;
use Test::More;

use Net::Stomp;
my $stomp = Net::Stomp->new( { hostname => 'localhost', port => '6163' } );
$stomp->connect( { login => 'guest', passcode => 'guest' } );
$stomp->send(
    { destination => '/queue/foo', body => '{"message":"foo"}' } );
$stomp->disconnect;

use AnyEvent;
use Log::Stash::Input::STOMP;
use Log::Stash::Output::Test;

my $cv = AnyEvent->condvar;
my $output = Log::Stash::Output::Test->new(
    cb => sub { $cv->send },
);
my $input = Log::Stash::Input::STOMP->new(
    output_to => $output,
);
ok $input;

$cv->recv;

is $output->message_count, 1;
is_deeply [$output->messages], [{message => "foo"}];

done_testing;

