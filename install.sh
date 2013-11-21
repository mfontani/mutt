cd ~/

mv .muttrc  .muttrc.old
mv .mailcap .mailcap.old

ln -s ~/.mutt/muttrc  .muttrc
ln -s ~/.mutt/mailcap .mailcap

mkdir -p ~/.mutt/cache/
