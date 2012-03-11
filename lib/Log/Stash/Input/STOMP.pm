package Log::Stash::Input::STOMP;
use Moose;
use AnyEvent;
use namespace::autoclean;

with qw/
    Log::Stash::STOMP::Role::HasAConnection
    Log::Stash::Role::Input
/;


1;

=head1 NAME

Log::Stash::Input::STOMP - input logstash messages from ZeroMQ.

=head1 DESCRIPTION

=head1 SEE ALSO

=over

=item L<Log::Stash::STOMP>

=item L<Log::Stash::Output::STOMP>

=item L<Log::Stash>

=item L<STOMP>

=item L<http://www.zeromq.org/>

=back

=head1 SPONSORSHIP

This module exists due to the wonderful people at Suretec Systems Ltd.
<http://www.suretecsystems.com/> who sponsored it's development for its
VoIP division called SureVoIP <http://www.surevoip.co.uk/> for use with
the SureVoIP API - 
<http://www.surevoip.co.uk/support/wiki/api_documentation>

=head1 AUTHOR, COPYRIGHT AND LICENSE

See L<Log::Stash>.

=cut

