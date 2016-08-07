TEMPLATE = app
QT += widgets qml quick
CONFIG += link_pkgconfig
PKGCONFIG += qdeclarative5-boostable

SOURCES +=     main.cpp
RESOURCES +=   resources.qrc
OTHER_FILES += main.qml

lupdate_only{
    SOURCES = main.qml
}

TARGET = asteroid-weather
target.path = /usr/bin/

desktop.files = asteroid-weather.desktop
desktop.path = /usr/share/applications

fonts.files = weathericons-regular-webfont.ttf
fonts.path = /usr/lib/fonts/

INSTALLS += target desktop fonts
