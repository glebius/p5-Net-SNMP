# -*- mode: perl -*-
# ============================================================================

package Net::SNMP::Transport::UNIX::Datagram;

# Object that handles the unix/stream Transport Domain for the SNMP Engine.

# Copyright (c) 2004-2009 David M. Town <dtown@cpan.org>
# Copyright (c) 2025 Gleb Smirnoff <glebius@cpan.org>
# All rights reserved.

# This program is free software; you may redistribute it and/or modify it
# under the same terms as the Perl 5 programming language system itself.

# ============================================================================

use strict;
use File::Temp qw(tempfile);
our $VERSION = v1.0.0;

use Net::SNMP::Transport qw( TRUE FALSE DOMAIN_UNIX_DGRAM );
use base qw( Net::SNMP::Transport::UNIX Net::SNMP::Transport::IPv4::UDP );

# [public methods] -----------------------------------------------------------

sub domain
{
   return DOMAIN_UNIX_DGRAM;
}

sub type
{
   return 'UNIX/Datagram';
}

# [private methods] ----------------------------------------------------------

sub _addr_any
{
    my $self = shift;
    my (undef, $sockname) = tempfile("snmpXXXXXXXXXXXXXX", OPEN => 0,
      TMPDIR => 1);
    $self->{sockname} = $sockname;
    return $sockname;
}

sub DESTROY {
   my $self = shift;
   unlink $self->{sockname} if -e $self->{sockname};
}

# ============================================================================
1; # [end Net::SNMP::Transport::UNIX::Datagram]

