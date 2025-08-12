CC = gcc
CFLAGS = -Wall -O2
PREFIX = /usr/local

seamless-login: seamless-login.c
	$(CC) $(CFLAGS) -o seamless-login seamless-login.c

install: seamless-login
	sudo install -m 755 seamless-login $(PREFIX)/bin/seamless-login

clean:
	rm -f seamless-login

.PHONY: install clean