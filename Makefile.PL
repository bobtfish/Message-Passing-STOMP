use strict;
use warnings;
use inc::Module::Install;

all_from 'lib/Message/Passing/STOMP.pm';

license 'AGPL_3';

requires 'Moose';
requires 'namespace::autoclean';
requires 'AnyEvent';
requires 'AnyEvent::STOMP' => '0.6';
requires 'JSON';
requires 'JSON::XS';
requires 'Try::Tiny';
requires 'Task::Weaken';
requires 'Message::Passing' => '0.001';

test_requires 'Test::More' => '0.88';

author_requires(
    'Test::Pod' => '1.14',
    'Test::NoTabs' => '0',
    'Test::Pod::Coverage' => '1.04',
    'Pod::Coverage' => '0.19',
    'Pod::Coverage::TrustPod' => '0',
    'Test::Spelling' => '0',
    'Net::Stomp' => '0',
);

author_tests 't/author';

if ($Module::Install::AUTHOR) {
    system("pod2text lib/Message/Passing/STOMP.pm > README")
        and die $!;
}

WriteAll;

