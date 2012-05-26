package Message::Passing::STOMP::Role::HasAConnection;
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

with 'Message::Passing::Role::HasAConnection';
use Message::Passing::STOMP::ConnectionManager;
sub _build_connection {
    my $self = shift;
    Message::Passing::STOMP::ConnectionManager->new(map { $_ => $self->$_() }
        qw/ username password ssl hostname /
    );
}

1;

=head1 NAME

Message::Passing::STOMP::HasAConnection - Role for instances which have a connection to a STOMP server.

=head1 ATTRIBUTES


=head1 AUTHOR, COPYRIGHT AND LICENSE

See L<Message::Passing::STOMP>.

=cut

