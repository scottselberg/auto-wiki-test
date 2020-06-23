#!/usr/bin/perl
package Selberg::AutoWikiTest;
use strict;
use warnings;
use vars qw(@ISA @EXPORT @EXPORT_OK %EXPORT_TAGS $VERSION);
use Exporter;
$VERSION = "1.0.1";
@ISA = ('Exporter');
@EXPORT = ( "&autoWikiTest" );
@EXPORT_OK = ();
%EXPORT_TAGS = ();

sub autoWikiTest
{
    print "AutoWikiTest\n";
}

1;
