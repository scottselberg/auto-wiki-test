#!/usr/bin/perl
use ExtUtils::MakeMaker;
use ExtUtils::Manifest qw(mkmanifest);

WriteMakefile(
   NAME => 'Selberg::AutoWikiTest',
   AUTHOR => 'Scott Selberg <saselberg@gmail.com>',
   VERSION_FROM => 'lib/Selberg/AutoWikiTest.pm',
   ABSTRACT     => 'A test module',
   PREREQ_PM => {},
);

mkmanifest();
