## -----------------------------------------------------------------
## Copyright (c) 2005-2006 BestSolution.at EDV Systemhaus GmbH
## All Rights Reserved.
##
## BestSolution.at GmbH MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE
## SUITABILITY OF THE SOFTWARE, EITHER EXPRESS OR IMPLIED, INCLUDING
## BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY,
## FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT.
## BestSolution.at GmbH SHALL NOT BE LIABLE FOR ANY DAMAGES SUFFERED BY
## LICENSEE AS A RESULT OF USING, MODIFYING OR DISTRIBUTING THIS
## SOFTWARE OR ITS DERIVATIVES.
## ----------------------------------------------------------------
##
## This library is free software; you can redistribute it and/or modify
## it under the same terms as Perl itself, either Perl version 5.8.6 or,
## at your option, any later version of Perl 5 you may have available.
##

package Apache2::TomKit::Processor::DefinitionProvider::FileSystemProvider;

use base qw( Apache2::TomKit::Processor::DefinitionProvider::AbstractProvider );

use strict;
use warnings;

use Apache2::TomKit::Util;

&Apache2::TomKit::Util::registerDefinitionProvider( "file://", __PACKAGE__ );
&Apache2::TomKit::Util::registerDefinitionProvider( "/", __PACKAGE__ );

sub init {
    my $this     = shift;
    my $filename = shift;

    $filename =~ s|^file://||;

	$this->{logger}->debug(9,"THe definition file is: " . $filename );

    $this->{definition} = $filename;
}

sub getProtocol {
    return "file://";
}

sub getMTime {
    return (stat($_[0]->{definition}))[9];
}

sub getInstructions {
    return $_[0]->{definition};
}

sub getContent {
	local $/ = undef;
	my $content = "";
	
	open( FILE, "<".$_[0]->{definition} );
		$content = <FILE>;
	close( FILE );
	
	return $content;
}

sub getKey {
    return $_[0]->{definition};
}

1;