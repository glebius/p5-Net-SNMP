# -*- mode: perl -*-
# ============================================================================

package Net::SNMP::Transport::UNIX::Stream;

# Object that handles the unix/stream Transport Domain for the SNMP Engine.

# Copyright (c) 2004-2009 David M. Town <dtown@cpan.org>
# Copyright (c) 2025 Gleb Smirnoff <glebius@cpan.org>
# All rights reserved.

# This program is free software; you may redistribute it and/or modify it
# under the same terms as the Perl 5 programming language system itself.

# ============================================================================

use strict;
our $VERSION = v1.0.0;

use Net::SNMP::Transport qw( TRUE FALSE DOMAIN_UNIX_STREAM );
use base qw( Net::SNMP::Transport::UNIX Net::SNMP::Transport::IPv4::TCP );

# [public methods] -----------------------------------------------------------

sub new
{
   my ($this, $error) = shift->SUPER::_new(@_);

   if (defined $this) {
      if (!defined $this->_reasm_init()) {
         return wantarray ? (undef, $this->error()) : undef;
      }
   }

   return wantarray ? ($this, $error) : $this;
}

sub domain
{
   return DOMAIN_UNIX_STREAM;
}

sub type
{
   return 'UNIX/Stream';
}

sub connectionless
{
   return FALSE;
}

sub needsbind
{
   return FALSE;
}

# [private methods] ----------------------------------------------------------

sub _addr_any
{
   return undef;
}

# ============================================================================
1; # [end Net::SNMP::Transport::UNIX::Stream]

