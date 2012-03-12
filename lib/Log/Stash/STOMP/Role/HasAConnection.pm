package Log::Stash::STOMP::Role::HasAConnection;
use Moose::Role;
use Scalar::Util qw/ weaken /;
use AnyEvent;
use AnyEvent::STOMP;
use namespace::autoclean;

has hostname => (
    is => 'ro',
    isa => 'Str',
    default => 'localhost',
);

has port => (
    is => 'ro',
    isa => 'Int',
    default => 5672,
);

has ssl => (
    is => 'ro',
    isa => 'Bool',
    default => 0,
);

has [qw/ username password /] => (
    is => 'ro',
    isa => 'Str',
    default => 'guest',
);

sub connected {}

has _connection => (
    is => 'ro',
    lazy => 1,
    default => sub {
        my $self = shift;
        weaken($self);
        warn("MOO $self");
        my $client = AnyEvent::STOMP->connect(
            $self->hostname, $self->port, $self->ssl, undef, undef,
            {},
            {
                '/topic/foo' => 1,
            },
        );
        $client->reg_cb(connect => sub {
            my ($client, $handle, $host, $port, $retry) = @_;
            warn("CONNECTED");
            $self->connected($client);
        });
        return $client;
    },
    clearer => '_clear_connection',
);

1;

=head1 NAME

Log::Stash::STOMP::HasAConnection - Role for instances which have a connection to a STOMP server.

=head1 ATTRIBUTES


=head1 AUTHOR, COPYRIGHT AND LICENSE

See L<Log::Stash::STOMP>.

=cut

