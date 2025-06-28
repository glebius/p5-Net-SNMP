# -*- mode: perl -*-
# ============================================================================

package Net::SNMP::Transport::UNIX;

# $Id$

# Base object for the unix(4) Transport Domains.

# Copyright (c) 2008-2009 David M. Town <dtown@cpan.org>
# Copyright (c) 2025 Gleb Smirnoff <glebius@cpan.org>
# All rights reserved.

# This program is free software; you may redistribute it and/or modify it
# under the same terms as the Perl 5 programming language system itself.

# ============================================================================

use strict;

use Net::SNMP::Transport;

use IO::Socket qw( PF_UNIX sockaddr_un unpack_sockaddr_un );
our $VERSION = v1.0.0;
use base qw( Net::SNMP::Transport );

sub new
{
   return shift->SUPER::_new(@_);
}

# [private methods] ----------------------------------------------------------

sub _socket_create
{
   my ($this) = @_;

   return IO::Socket->new()->socket($this->_protocol_family(),
                                    $this->_protocol_type(),
                                    $this->_protocol());
}

sub _protocol_family
{
   return PF_UNIX;
}

sub _addr_loopback
{
   return '/var/run/snmpd.sock';
}

sub _address
{
   return $_[1];
}

sub _addr
{
   return (unpack_sockaddr_un($_[1]));
}

sub _hostname_resolve
{
   my ($this, $host, $nh) = @_;

   return ($nh->{addr} = $host);
}

sub _name_pack
{
   if (defined($_[1]->{addr})) {
      return sockaddr_un($_[1]->{addr});
   } else {
      return undef;
   }
}

sub _taddress
{
   return sprintf '%s', $_[0]->_address($_[1]);
}

# ============================================================================
1; # [end Net::SNMP::Transport::UNIX]

