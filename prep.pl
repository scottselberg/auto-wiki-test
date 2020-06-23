#!/usr/bin/perl
use ExtUtils::MakeMaker;
use ExtUtils::Manifest qw(mkmanifest);

WriteMakefile(
   NAME => 'Selberg::AutoWikiTest',
   VERSION_FROM => 'lib/Selberg/AutoWikiTest.pm'
);

mkmanifest();
