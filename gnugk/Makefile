all: dependencies grab update build

dependencies:
	@make dependencies_`uname -s`

dependencies_Darwin:
	@if [ ! -d /usr/local/Cellar/subversion ]; then \
	  brew install subversion ; \
	fi
	@if [ ! -d /usr/local/Cellar/net-snmp ]; then \
	  brew install net-snmp ; \
	fi
	@if [ ! -d /usr/local/Cellar/libssh2 ]; then \
	  brew install libssh2 ; \
	fi

dependencies_Linux:
	@if ! grep -e '^deb-src' /etc/apt/sources.list > /dev/null ; then cp -f /etc/apt/sources.list /tmp/sources.list; sed -e 's/^deb /deb-src/' < /tmp/sources.list >> /etc/apt/sources.list; apt-get update; fi
	@apt-get update
	@apt-get install build-essential subversion cvs libsnmp-dev libssh-dev
	@apt-get -f -y build-dep ptlib
	@apt-get -f -y build-dep h323plus
	@apt-get -f -y build-dep gnugk

grab:
	@if [ ! -d ptlib-v2.10.1 ] ; then svn co http://opalvoip.svn.sourceforge.net/svnroot/opalvoip/ptlib/tags/v2_10_1 ptlib-v2.10.1/ ; fi
	@if [ ! -f ~/.cvspass ]; then echo '/1 :pserver:anonymous@h323plus.cvs.sourceforge.net:2401/cvsroot/h323plus A' > ~/.cvspass; echo '/1 :pserver:anonymous@openh323gk.cvs.sourceforge.net:2401/cvsroot/openh323gk A' >> ~/.cvspass ; fi
	@if [ ! -d h323plus ] ; then cvs -z3 -d:pserver:anonymous@h323plus.cvs.sourceforge.net:/cvsroot/h323plus co -P h323plus ; fi
	@if [ ! -d openh323gk ]; then cvs -z3 -d:pserver:anonymous@openh323gk.cvs.sourceforge.net:/cvsroot/openh323gk co -P openh323gk ; fi

update:
	@cd ptlib-v2.10.1 && svn update
	@cd h323plus && cvs update
	@cd openh323gk && cvs update

build:
	@make ptlib-build
	@make h323plus-build
	@make openh323gk-build

ptlib-build:
	cd ptlib-v2.10.1 && \
	export PTLIBDIR=`pwd` && \
	./configure --disable-alsa \
                    --disable-oss \
                    --disable-v4l \
                    --disable-avc \
                    --disable-dc \
                    --disable-sdl \
                    --disable-odbc \
                    --enable-exceptions \
                    --enable-openssl && \
        make clean && \
        make -j4 debugnoshared

h323plus-build:
	if [ -f h323plus/openh323u.mak ]; then rm -f h323plus/openh323u.mak ; fi
	export PTLIBDIR=`pwd`/ptlib-v2.10.1 && \
	export OPENH323DIR=`pwd`/h323plus && \
	export CFLAGS=-I`pwd`/h323plus/include && \
	cd h323plus && \
	./configure --enable-h350 \
	            --enable-plugins \
	            --enable-h46019m \
	            --enable-h46019 \
	            --enable-h46023 \
	            --enable-h46026 \
	            --enable-h4609 \
	            --enable-h460p \
	            --enable-h235 \
	            --enable-h46017 && \
	make -j4 clean debugnoshared debugstatic

openh323gk-build:
	export PTLIBDIR=`pwd`/ptlib-v2.10.1 && \
	export OPENH323DIR=`pwd`/h323plus && \
	export CFLAGS=-I`pwd`/h323plus/include && \
	cd openh323gk && \
	./configure --with-pgsql-include-dir=/usr/include/postgresql \
	            --with-large-fdset=32767 \
	            --enable-h46018 \
	            --enable-sqlite \
	            --enable-mysql \
	            --disable-unixodbc \
	            --enable-h46023 \
	            --with-libssh-dir=/usr \
	            --disable-netsnmp && \
	make -j4 clean debugstatic debugnoshared

