# -*- perl -*-
use v5.14;

use SSSFS::Local;
use File::Path::Tiny;
use Path::Class;
use Digest::SHA1 qw(sha1_hex);
use Test::More;

my $local_dir = file(__FILE__)->dir->subdir("sssfs-local-t");

File::Path::Tiny::mk($local_dir);

my $local = SSSFS::Local->new(root => $local_dir);
my $object_dir  = $local_dir->subdir("objects");

subtest "`objects` directory is created" => sub {
    ok -d "$local_dir";
};

subtest "`add_key` methods creates objects files" => sub {
    $local->add_key("/foo/bar.txt", "The content of bar.");

    my $digest = sha1_hex("/foo/bar.txt");

    my $object_files = {
        body => $object_dir->file( "${digest}.body" ),
        head => $object_dir->file( "${digest}.head" ),
        name => $object_dir->file( "${digest}.name" ),
        digest => $object_dir->file( "${digest}.digest" )
    };

    ok -d "$object_dir";
    for (values %$object_files) { ok -f $_, "$_ exists"; }

};


done_testing;


File::Path::Tiny::rm($local_dir);
