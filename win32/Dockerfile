FROM fedora:30

VOLUME /source

# Installs dependencies once and for all
RUN dnf -y update --refresh
RUN dnf -y install cmake git fpc gettext glib2-devel itstool libxslt make yelp-tools zip
RUN dnf -y install mingw32-biblesync mingw32-dbus-glib mingw32-gdb mingw32-gettext mingw32-gtk3 mingw32-libglade2 mingw32-libidn mingw32-libsoup mingw32-minizip mingw32-nsis mingw32-sword mingw32-libtiff mingw32-webkitgtk
RUN dnf -y install mingw64-biblesync mingw64-dbus-glib mingw64-gdb mingw64-gettext mingw64-gtk3 mingw64-libglade2 mingw64-libidn mingw64-libsoup mingw64-minizip              mingw64-sword mingw64-libtiff mingw64-webkitgtk

ENTRYPOINT ["/bin/bash", "/source/win32/xc-xiphos-win.sh"]

CMD ["-win32", "-win64"]
