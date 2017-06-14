default-target: all
default-target: .PHONY
.PHONY:

APT_DIR = /etc/apt
APT_KEY = apt-key
GNUPGHOME = /nonexistent/please/specify/gpghome
GPG = gpg
INSTALL = install
INSTALL_DIR = install -d

PRINCIPALS = \
	archive/probcomp-ubuntu/20170329-9A593051 \
	axch \
	riastradh \
	# end of principals

all: .PHONY
	@echo nothing to build

check: .PHONY
	@echo $(GNUPGHOME)

install: .PHONY
	$(INSTALL_DIR) $(DESTDIR)$(APT_DIR)/trusted.gpg.d
	$(APT_KEY) --keyring $(DESTDIR)$(APT_DIR)/trusted.gpg.d/probcomp.gpg \
		add ./probcomp-ubuntu.asc

keyring: .PHONY
keyring: ./merge.sh
keyring: $(PRINCIPALS:=.asc)
	rm -f probcomp-ubuntu.asc.tmp
	sh ./merge.sh $(PRINCIPALS:=.asc) > probcomp-ubuntu.asc.tmp
	mv -f probcomp-ubuntu.asc.tmp probcomp-ubuntu.asc

%.dry: %.param
	rm -f $@.tmp
	cat < $< \
	| $(GPG) --homedir $(GNUPGHOME) --batch --gen-key \
	| tee $@.tmp
	mv -f $@.tmp $@
%.asc: %.param
	rm -f $@.tmp
	sed -e 's,^%dry-run$$,%commit,1' < $< \
	| $(GPG) --homedir $(GNUPGHOME) --batch --gen-key
	$(GPG) --homedir $(GNUPGHOME) \
		--armour --no-emit-version --export-options export-clean \
		--export $* > $@.tmp
	mv -f $@.tmp $@

gpghome: .PHONY
	mkdir -m 0700 $(GNUPGHOME)
