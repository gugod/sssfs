use v5.14;
package SSSFS::Local;
use Moose;
use Path::Class;
use File::Path::Tiny;
use Digest::SHA1 qw(sha1_hex);
use JSON;

has root => (
    is => "ro",
    isa => "Path::Class::Dir",
    required => 1
);

sub BUILD {
    my ($self) = @_;

    my $odir = $self->root->subdir("objects");

    unless (-d $odir) {
        File::Path::Tiny::mk($odir);
    }
}

sub add_key {
    my ($self, $key, $value, $attributes) = @_;

    my $digest = sha1_hex($key);

    unless (defined($attributes)) {
        $attributes = {};
    }

    my $od = $self->root->subdir("objects");

    for my $x ([body => $value], [name => $key], [head => encode_json($attributes)], [digest => sha1_hex($value)]) {
        my $ofh = $od->file("${digest}." . $x->[0])->openw;
        print $ofh $x->[1];
        close $ofh;

    }
}

1;
