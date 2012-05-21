package Log::Stash::STOMP::Role::HasAConnection;
use Moose::Role;
use namespace::autoclean;

has hostname => (
    is => 'ro',
    isa => 'Str',
    default => 'localhost',
);

has port => (
    is => 'ro',
    isa => 'Int',
    default => 6163,
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

with 'Log::Stash::Role::HasAConnection';
use Log::Stash::STOMP::ConnectionManager;
sub _build_connection {
    my $self = shift;
    Log::Stash::STOMP::ConnectionManager->new(map { $_ => $self->$_() }
        qw/ username password ssl hostname /
    );
}

1;

=head1 NAME

Log::Stash::STOMP::HasAConnection - Role for instances which have a connection to a STOMP server.

=head1 ATTRIBUTES


=head1 AUTHOR, COPYRIGHT AND LICENSE

See L<Log::Stash::STOMP>.

=cut

