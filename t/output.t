use strict;
use warnings;
use Test::More;

use AnyEvent;
use Log::Stash::Input::STOMP;
use Log::Stash::Output::Test;
use Log::Stash::Output::STOMP;

my $output = Log::Stash::Output::STOMP->new(
    exchange_name => "log_stash_test",
);
my $cv = AnyEvent->condvar;
my $timer; $timer = AnyEvent->timer(after => 2, cb => sub { undef $timer; $cv->send });
$cv->recv;
$output->consume({foo => 'bar'});

use Log::Stash::Input::STOMP;
use Log::Stash::Output::Test;
$cv = AnyEvent->condvar;
my $input = Log::Stash::Input::STOMP->new(
    output_to => Log::Stash::Output::Test->new(
        on_consume_cb => sub { $cv->send }
    ),
);
$cv->recv;

is $input->output_to->message_count, 1;
is_deeply([$input->output_to->messages], [{foo => 'bar'}]);

done_testing;

