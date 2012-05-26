package Message::Passing::STOMP;
use Moose ();
use namespace::autoclean;

our $VERSION = "0.001";
$VERSION = eval $VERSION;

1;

=head1 NAME

Message::Passing::STOMP - input and output messages to STOMP.

=head1 SYNOPSIS

    # Terminal 1:
    $ logstash --input STDIN --output STOMP --output_options '{"FIXME"}'
    {"data":{"some":"data"},"@metadata":"value"}

    # Terminal 2:
    $ logstash --output STDOUT --input STOMP --input_options '{"FIXME"}'
    {"data":{"some":"data"},"@metadata":"value"}

=head1 DESCRIPTION

A L<AnyEvent::STOMP> transport for L<Message::Passing>.

=head1 SEE ALSO

=over

=item L<Message::Passing::Output::STOMP>

=item L<Message::Passing::Input::STOMP>

=item L<Message::Passing>

=item L<AnyEvent::STOMP>


=back

=head1 AUTHOR

Tomas (t0m) Doran <bobtfish@bobtfish.net>

=head1 COPYRIGHT

Copyright The above mentioned AUTHOR 2012.

=head1 LICENSE

GNU Affero General Public License, Version 3

If you feel this is too restrictive to be able to use this software,
please talk to us as we'd be willing to consider re-licensing under
less restrictive terms.

=cut

1;

