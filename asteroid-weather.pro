TARGET = asteroid-weather
CONFIG += asteroidapp

SOURCES +=     main.cpp
RESOURCES +=   resources.qrc
OTHER_FILES += main.qml

lupdate_only{ SOURCES += i18n/asteroid-weather.desktop.h }
TRANSLATIONS = $$files(i18n/$$TARGET.*.ts)
