#!/usr/bin/tclsh

set arch "noarch"
set base "tclws-2.5.0"
set fileurl "http://core.tcl.tk/tclws/tarball/Web+Services+for+Tcl+%28aka+tclws%29-53f12a2aa1.tar.gz"

set var [list wget $fileurl -O $base.tar.gz]
exec >@stdout 2>@stderr {*}$var

set var [list tar xzvf $base.tar.gz]
exec >@stdout 2>@stderr {*}$var

file rename -force Web_Services_for_Tcl__aka_tclws_-53f12a2aa1 $base
file delete -force $base.tar.gz

set var [list tar czvf $base.tar.gz $base]
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

