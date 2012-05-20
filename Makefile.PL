use strict;
use warnings;
use inc::Module::Install;

all_from 'lib/Log/Stash/STOMP.pm';

license 'AGPL_3';

requires 'Moose';
requires 'namespace::autoclean';
requires 'AnyEvent';
requires 'AnyEvent::STOMP' => '0.6';
requires 'JSON';
requires 'JSON::XS';
requires 'Try::Tiny';
requires 'Task::Weaken';
requires 'Log::Stash' => '0.001';

test_requires 'Test::More' => '0.88';

author_requires 'Test::Pod' => '1.14';
author_requires 'Test::NoTabs';
author_requires 'Test::Pod::Coverage' => '1.04';
author_requires 'Pod::Coverage' => '0.19';
author_requires 'Pod::Coverage::TrustPod';
author_requires 'Test::Spelling';

author_tests 't/author';

if ($Module::Install::AUTHOR) {
    system("pod2text lib/Log/Stash/STOMP.pm > README")
        and die $!;
}

WriteAll;

