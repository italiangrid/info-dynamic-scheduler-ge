%define topdir %(pwd)/rpmbuild
%define _topdir %{topdir} 
Summary: The SGE information plugin to gLite middleware 
Name: glite-info-dynamic-sge
Version: x
Vendor: EGEE
Release: x
License: EGEE
Group: EGEE
Source: %{name}.src.tgz
BuildArch: noarch
Prefix: /opt/glite
Requires: perl-XML-Twig >= 3.0
BuildRoot: %{_tmppath}/%{name}-%{version}-build
Packager: EGEE

%description
This package contains the information plugin to gLite middleware

%prep

%setup -c

%build
make install prefix=%{buildroot}%{prefix}

%files
%defattr(0755,root,root)
%config(noreplace) %{prefix}/libexec/sge_helper
%defattr(0644,root,root)
%{prefix}/share/doc/glite-info-dynamic-sge/AUTHORS
%{prefix}/share/doc/glite-info-dynamic-sge/CREDITS
%{prefix}/share/doc/glite-info-dynamic-sge/LICENSE
%{prefix}/share/doc/glite-info-dynamic-sge/License.GPL
%{prefix}/share/doc/glite-info-dynamic-sge/README
%{prefix}/share/doc/glite-info-dynamic-sge/cluster.state.template
%{prefix}/share/doc/glite-info-dynamic-sge/sample-info-reporter.conf.template
%{prefix}/share/doc/glite-info-dynamic-sge/sample-vqueues.conf.template
%{prefix}/share/doc/glite-info-dynamic-sge/compare-output

%clean
rm -rf %{buildroot}

