echo "Building IconHeck and installing to WoW directory."

touch IconHeck.toc.tmp

cat IconHeck.toc > IconHeck.toc.tmp

sed -i "s/@project-version@/$(git describe --abbrev=0)/g" IconHeck.toc.tmp

mkdir -p /h/games/World\ of\ Warcraft/_classic_/Interface/AddOns/IconHeck/

cp *.lua *.ogg /h/games/World\ of\ Warcraft/_classic_/Interface/AddOns/IconHeck/

cp IconHeck.toc.tmp /h/games/World\ of\ Warcraft/_classic_/Interface/AddOns/IconHeck/IconHeck.toc

rm IconHeck.toc.tmp

echo "Complete."