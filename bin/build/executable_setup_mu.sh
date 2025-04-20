#!/usr/bin/env sh

mu init --maildir ~/Maildir/ --my-address=simon.theoret99@gmail.com
mu index
mbsync -a
