package Log::Stash::Output::STOMP;
use Moose;
use namespace::autoclean;

with qw/
    Log::Stash::STOMP::Role::HasAConnection
    Log::Stash::Role::Output
/;

sub BUILD {
    my $self = shift;
    $self->_connection;
}

sub consume {
    my $self = shift;
    my $data = shift;
    my $bytes = $self->encode($data);
    my $destination = '/topic/foo';
    my $headers = undef;
    $self->_connection->send($bytes, $destination, $headers);
}

__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Log::Stash::Output::STOMP - output logstash messages to ZeroMQ.

=head1 SYNOPSIS

    use Log::Stash::Output::STOMP;

    my $logger = Log::Stash::Output::STOMP->new;
    $logger->consume({data => { some => 'data'}, '@metadata' => 'value' });

    # You are expected to produce a logstash message format compatible message,
    # see the documentation in Log::Stash for more details.

    # Or use directly on command line:
    logstash --input STDIN --output STOMP
    {"data":{"some":"data"},"@metadata":"value"}

=head1 DESCRIPTION

A L<Log::Stash> L<AnyEvent::RabbitMQ> output class.

Can be used as part of a chain of classes with the L<logstash> utility, or directly as
a logger in normal perl applications.

=head1 CAVEAT

You cannot send STOMP messages and then call fork() and send more ZeroMQ messages!

=head1 METHODS

=head2 consume

Sends a message.

=head1 SEE ALSO

=over

=item L<Log::Stash::STOMP>

=item L<Log::Stash::Input::STOMP>

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

