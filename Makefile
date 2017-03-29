default-target: all
default-target: .PHONY
.PHONY:

APT_DIR = /etc/apt
APT_KEY = apt-key
INSTALL = install
INSTALL_DIR = install -d

all: .PHONY
	@echo nothing to build

install: .PHONY
	$(INSTALL_DIR) $(DESTDIR)$(APT_DIR)/trusted.gpg.d
	$(APT_KEY) --keyring $(DESTDIR)$(APT_DIR)/trusted.gpg.d/probcomp.asc \
		add ./probcomp-ubuntu.asc
