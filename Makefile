default-target: all
default-target: .PHONY
.PHONY:

all: .PHONY
	@echo nothing to build

install: .PHONY
	apt-key --keyring $(DESTDIR)/etc/apt/trusted.gpg.d/probcomp.asc \
		add ./probcomp-ubuntu.asc
