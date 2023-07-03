COPYCMD := cp -iu

# Installs via hard links so changes are synchronized
install:
	$(COPYCMD) .bashrc $(HOME)/
	$(COPYCMD) -r .bashrc.d $(HOME)/
	$(COPYCMD) -r .bash_profile.d $(HOME)/
