%{!?directory:%define directory /usr}

%define buildroot %{_tmppath}/%{name}

Name:          tclws
Summary:       Web Services for Tcl
Version:       3.3.0
Release:       0
License:       BSD-3-Clause
Group:         Development/Libraries/Tcl
Source:        %{name}-%{version}.tar.gz
URL:           http://core.tcl.tk/tclws/index
BuildArch:     noarch
BuildRequires: make
Requires:      tcl >= 8.6
Requires:      tdom >= 0.8.1
Requires:      tcllib
Requires:      tls
BuildRoot:     %{buildroot}

%description
TclWS provides both client side access to Web Services and server
side creation of Web Services. Currently only document/literal and
rpc/encoded with HTTP Soap transport are supported on the client side.

%prep
%setup -q -n %{name}-%{version}

%build
make 

%install
make TARGETDIR=%{buildroot}%{_datadir}/tcl/%{name}%{version} install

%clean
rm -rf %buildroot

%files
%defattr(-,root,root)
%{_datadir}/tcl

