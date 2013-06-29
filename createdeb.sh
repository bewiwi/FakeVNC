#!/bin/bash
WorkFolder=/tmp/build-Fake/fakevnc

cd $(dirname $0)

#Creation des dossiers
rm -rf $WorkFolder
mkdir -p $WorkFolder/{DEBIAN,usr/bin,etc/init.d}

#Copy des fichiers
cp fakeVnc.py $WorkFolder/usr/bin/fakevnc
cp fakeVnc.conf $WorkFolder/etc/
cp initscript $WorkFolder/etc/init.d/fakevnc

#Creation du fichier de CONTROL
cat <<EOF > $WorkFolder/DEBIAN/control
Package: fakevnc
Version: 1.0
Section: base
Architecture: all
Depends: python
Maintainer: PORTE Loic <bewiwi@bibabox.fr>
Description: Fake TCP server
EOF


cat <<EOF > $WorkFolder/DEBIAN/postinst
#!/bin/bash
update-rc.d fakevnc defaults
EOF
chmod 755 $WorkFolder/DEBIAN/postinst

dpkg-deb --build $WorkFolder
