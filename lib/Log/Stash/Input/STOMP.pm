package Log::Stash::Input::STOMP;
use Moose;
use AnyEvent;
use Scalar::Util qw/ weaken /;
use namespace::autoclean;

with qw/
    Log::Stash::STOMP::Role::HasAConnection
    Log::Stash::Role::Input
/;

sub BUILD {
    my $self = shift;
    $self->_connection;
}

sub destination { '/queue/foo' }

my $id = 0;
after connected => sub {
    my ($self, $client) = @_;
    weaken($self);
    $client->reg_cb(MESSAGE => sub {
        my (undef, $body, $headers) = @_;
        $self->output_to->consume($self->decode($body));
    });
    my $subscribe_headers = {
        id => $id++,
        destination => $self->destination,
        ack => 'auto',
    };
    $client->send_frame('SUBSCRIBE',
        undef, $subscribe_headers);
};

__PACKAGE__->meta->make_immutable;
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

