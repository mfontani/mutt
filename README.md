My Very Opinionated .muttrc
===========================

This is my .muttrc and the associated files.

To install:
===========

    $ cd ~
    $ mv .mutt .mutt.old
    $ git clone THIS_REPO ~/.mutt
    $ cd ~/.mutt/
    $ sh install.sh

To configure:
=============

    $ cd ~/.mutt/

1. Credentials

    $ vim ~/.mutt/credentials

Create one entry for each of your accounts, like:

    set my_gmail_pass="foobar"
    set my_foobardomain_pass="barbaz"

2. Accounts

Modify the existing stanzas so that there's one for each of the passwords you
added in the previous step

3. Aliases

    $ vim ~/.mutt/aliases

Add aliases in this format:

    alias aliasname    Full Name    <email@foobar.com>
    alias anotheralias Another Name <barbaz@example.com>

4. Muttrc

* Set your "editor" to whatever you prefer (lines 10-13)
* Set your GPG key ID (line 90)
* Change what you want colored in your emails (line 99)
* Change macroes to switch accounts (lines 107-110)
* set default account and inbox (line 113)
* change default BCC (line 125) else I get all your sent emails.

That should be about it.
========================
