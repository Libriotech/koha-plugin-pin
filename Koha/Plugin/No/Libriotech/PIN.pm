package Koha::Plugin::No::Libriotech::PIN;

use Modern::Perl;

## Required for all plugins
use base qw(Koha::Plugins::Base);

use Koha::Exceptions::Password::TooShort;

our $VERSION = "0.0.1";

## Here is our metadata, some keys are required, some are optional
our $metadata = {
    name            => 'PIN',
    author          => 'Magnus Enger',
    date_authored   => '2019-10-02', # At the hackfest in Marseille!
    date_updated    => '2019-10-02',
    minimum_version => '19.11',
    maximum_version => undef,
    version         => $VERSION,
    description     => 'Make sure password is a 4 digit PIN code',
};

=head1 new()

Standard for all plugins.

=cut

sub new {
    my ( $class, $args ) = @_;

    ## We need to add our metadata here so our base class can access it
    $args->{'metadata'} = $metadata;
    $args->{'metadata'}->{'class'} = $class;

    ## Here, we call the 'new' method for our base class
    ## This runs some additional magic and checking
    ## and returns our actual $self
    my $self = $class->SUPER::new($args);

    return $self;
}

=head1 check_password()

This is the plugin subroutine that gets called from inside the Koha code.

=cut

sub check_password {

    my ( $self, $args ) = @_;

    my $password = $args->{'password'};
    if ( $password && $password =~ m/^\d\d\d\d$/ ) {
        return {
            error => 0,
        };
    } else {
        return {
            error => 1,
            msg   => "PIN should be four digits",
        };
    }

}

1;

=head1 AUTHOR

Magnus Enger <digitalutvikling@gmail.com>
Magnus Enger <magnus@libriotech.no>

=head1 COPYRIGHT

Copyright 2014 Oslo Public Library
Copyright 2019 Libriotech AS

=head1 LICENSE

This file is part of Koha.

Koha is free software; you can redistribute it and/or modify it under the terms
of the GNU General Public License as published by the Free Software Foundation;
either version 3 of the License, or (at your option) any later version.

You should have received a copy of the GNU General Public License along with
Koha; if not, write to the Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA.

=cut
