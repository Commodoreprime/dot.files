COPYCMD := cp -vu

install:
	$(COPYCMD) .bashrc $(HOME)/
	$(COPYCMD) .bash_profile $(HOME)/
	$(COPYCMD) -r .bashrc.d $(HOME)/
	$(COPYCMD) -r .bash_profile.d $(HOME)/
