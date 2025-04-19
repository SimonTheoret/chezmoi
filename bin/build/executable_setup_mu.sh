#!/usr/bin/env sh

mu init --maildir ~/maildir/ --my-address=simon.theoret99@gmail.com
mu index
mbsync -a
