TEMPLATE = app
QT += qml quick
CONFIG += link_pkgconfig
PKGCONFIG += qdeclarative5-boostable

SOURCES +=     main.cpp
RESOURCES +=   resources.qrc
OTHER_FILES += main.qml

lupdate_only{
    SOURCES = main.qml
    SOURCES = i18n/asteroid-weather.desktop.h
}

# Needed for lupdate
TRANSLATIONS = i18n/asteroid-weather.ca.ts \
               i18n/asteroid-weather.ckb.ts \
               i18n/asteroid-weather.cs.ts \
               i18n/asteroid-weather.de.ts \
               i18n/asteroid-weather.el.ts \
               i18n/asteroid-weather.es.ts \
               i18n/asteroid-weather.fa.ts \
               i18n/asteroid-weather.fr.ts \
               i18n/asteroid-weather.hu.ts \
               i18n/asteroid-weather.it.ts \
               i18n/asteroid-weather.kab.ts \
               i18n/asteroid-weather.ko.ts \
               i18n/asteroid-weather.nl.ts \
               i18n/asteroid-weather.pl.ts \
               i18n/asteroid-weather.pt_BR.ts \
               i18n/asteroid-weather.ru.ts \
               i18n/asteroid-weather.sk.ts \
               i18n/asteroid-weather.ta.ts \
               i18n/asteroid-weather.tr.ts \
               i18n/asteroid-weather.uk.ts \
               i18n/asteroid-weather.zh_Hans.ts

TARGET = asteroid-weather
target.path = /usr/bin/

desktop.commands = bash $$PWD/i18n/generate-desktop.sh $$PWD asteroid-weather.desktop
desktop.files = $$OUT_PWD/asteroid-weather.desktop
desktop.path = /usr/share/applications
desktop.CONFIG = no_check_exist

fonts.files = weathericons-regular-webfont.ttf
fonts.path = /usr/lib/fonts/

INSTALLS += target desktop fonts
