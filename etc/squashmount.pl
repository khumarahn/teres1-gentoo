#!/usr/bin/perl (this is only for editors)

@order = qw(overlayfs? overlay);

$obsolete_overlayfs = 1;

$rm_changes = $rm_workdir = $rm_readonly = 0;

my $defaults = {
    COMPRESSION => 'xz',
    COMPOPT_XZ => ['-Xbcj', 'arm'],
};

@mounts = (
    standard_mount('portage', '/usr/portage', $defaults),
);

1;  # The last executed command in this file should be a true expression
