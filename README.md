# sssfs

## Install

    cpanm DateTime::Format::ISO8601 Digest::SHA1 Fuse Moose Net::Amazon::S3 Path::Class YAML
    git clone git://github.com/gugod/sssfs.git
    cp sssfs /usr/local/bin

## Setup

    export EC2_ACCESS_KEY=xxx
    export EC2_SECRET_KEY=yyy

## Usage

    sssfs <bucket_name> <mount_point>
