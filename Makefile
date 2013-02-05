prefix=/opt/glite
package=glite-info-dynamic-sge
name=$Name:  $
tag:=$(shell echo $(name) | sed 's/^[^:]*: //' )
version:=$(shell echo "$(tag)" | sed 's/^.*R_//' | sed 's/_/\./g')
release:=$(shell echo "$(version)" | sed 's/.*\.//')
version:=$(shell echo "$(version)" | sed 's/\(.*\)\.[0-9]*/\1/')

.PHONY: configure install clean rpm

all: configure

install: 
	@echo installing ...
	@mkdir -p $(prefix)/libexec/
        
	@install -m 0644 src/sge_helper $(prefix)/libexec/sge_helper

	@mkdir -p $(prefix)/share/
	@mkdir -p $(prefix)/share/doc/
	@mkdir -p $(prefix)/share/doc/glite-info-dynamic-sge/

	@install -m 0644 doc/AUTHORS $(prefix)/share/doc/glite-info-dynamic-sge/AUTHORS
	@install -m 0644 doc/CREDITS $(prefix)/share/doc/glite-info-dynamic-sge/CREDITS        
	@install -m 0644 doc/LICENSE $(prefix)/share/doc/glite-info-dynamic-sge/LICENSE
	@install -m 0644 doc/License.GPL $(prefix)/share/doc/glite-info-dynamic-sge/License.GPL        
	@install -m 0644 doc/README $(prefix)/share/doc/glite-info-dynamic-sge/README
	@install -m 0644 etc/cluster.state.template $(prefix)/share/doc/glite-info-dynamic-sge/cluster.state.template
	@install -m 0644 etc/sample-info-reporter.conf.template $(prefix)/share/doc/glite-info-dynamic-sge/sample-info-reporter.conf.template
	@install -m 0644 etc/sample-vqueues.conf.template $(prefix)/share/doc/glite-info-dynamic-sge/sample-vqueues.conf.template
	@install -m 0644 etc/compare-output $(prefix)/share/doc/glite-info-dynamic-sge/compare-output
clean::
	rm -rf rpmbuild 
	rm -rf RPMS
rpm:
	@mkdir -p  RPMS
	@mkdir -p  rpmbuild/RPMS/noarch
	@mkdir -p  rpmbuild/SRPMS/
	@mkdir -p  rpmbuild/SPECS/
	@mkdir -p  rpmbuild/SOURCES/
	@mkdir -p  rpmbuild/BUILD/
ifneq ("$(tag)","ame:")
	@sed -i 's/^Version:.*/Version: $(version)/' $(package).spec
	@sed -i 's/^Release:.*/Release: $(release)/' $(package).spec
endif
	@tar --gzip --exclude='*CVS*' -cf rpmbuild/SOURCES/${package}.src.tgz *
	rpmbuild -ba ${package}.spec
	cp rpmbuild/RPMS/noarch/*.rpm rpmbuild/SRPMS/*.rpm RPMS/.




