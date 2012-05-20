package Log::Stash::STOMP::Role::HasAConnection;
use Moose::Role;
use Scalar::Util qw/ weaken /;
use AnyEvent;
use AnyEvent::STOMP;
use Carp qw/ croak /;
use namespace::autoclean;

BEGIN { # For RabbitMQ https://rt.cpan.org/Ticket/Display.html?id=68432
    if ($AnyEvent::STOMP::VERSION <= 0.6) {
        no warnings 'redefine';
        sub AnyEvent::STOMP::send_frame {
            my $self = shift;
            my ($command, $body, $headers) = @_;

            croak 'Missing command' unless $command;

            $headers->{'content-length'} = length $body || 0;
            $body = '' unless defined $body;

            my $frame = sprintf("%s\n%s\n\n%s\000",
                        $command,
                        join("\n", map { "$_:$headers->{$_}" } keys %$headers),
                        $body);
            $self->{handle}->push_write($frame);
        }
    }
}

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

sub connected {}

sub destination { '/queue/foo' }

has _connection => (
    is => 'ro',
    lazy => 1,
    default => sub {
        my $self = shift;
        weaken($self);
        Carp::cluck("MOO $self");
        my $client = AnyEvent::STOMP->connect(
            $self->hostname, $self->port, $self->ssl, undef, 0,
            {
                'accept-version' => '1.1',
                host => '/',
                login => $self->username,
                passcode => $self->password,
            },
            {},
        );
        $client->reg_cb(CONNECTED => -2000 => sub {
            my ($client, $handle, $host, $port, $retry) = @_;
            $self->connected($client);
        });
        $client->reg_cb(io_error => sub {
            my ($client, $errmsg) = @_;
            warn("IO ERROR $errmsg");
            $self->_clear_connection;
        });
        $client->reg_cb(connect_error =>  sub {
            my ($client, $errmsg) = @_;
            warn("CONNECT ERROR $errmsg");
            $self->_clear_connection;
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

