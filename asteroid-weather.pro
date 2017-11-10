TARGET = asteroid-weather
CONFIG += asteroidapp

SOURCES +=     main.cpp
RESOURCES +=   resources.qrc
OTHER_FILES += main.qml

lupdate_only{ SOURCES = main.qml i18n/$$TARGET.desktop.h }
TRANSLATIONS = $$files(i18n/$$TARGET.*.ts)
