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
    default => 61613,
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

sub destination { undef }

has _connection => (
    is => 'ro',
    lazy => 1,
    default => sub {
        my $self = shift;
        weaken($self);
        warn("MOO $self");
        my $client = AnyEvent::STOMP->connect(
            $self->hostname, $self->port, $self->ssl, $self->destination, undef,
            {},
            {},
        );
        $client->reg_cb(frame => sub {
            my ($client, $type, $body, $headers) = @_;
            use Data::Dumper;
            warn Dumper({type => $type, body => $body, headers => $headers});
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

