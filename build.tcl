#!/usr/bin/tclsh

set arch "noarch"
set base "tclws-3.5.0"
set fileurl "http://core.tcl.tk/tclws/tarball/$base.tar.gz"

set var [list wget2 $fileurl -O $base.tar.gz]
exec >@stdout 2>@stderr {*}$var

if {[file exists build]} {
    file delete -force build
}

file mkdir build/BUILD build/RPMS build/SOURCES build/SPECS build/SRPMS
file copy -force $base.tar.gz build/SOURCES

set buildit [list rpmbuild --target $arch --define "_topdir [pwd]/build" -bb tclws.spec]
exec >@stdout 2>@stderr {*}$buildit

# Remove our source code
file delete $base.tar.gz
file delete -force $base

