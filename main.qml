/*
 * Copyright (C) 2016 - Florent Revest <revestflo@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.4
import org.asteroid.controls 1.0
import org.nemomobile.configuration 1.0
import 'qrc:/icons.js' as IconTools

Application {
    id: app

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#72a8e4" }
            GradientStop { position: 1.0; color: "#1a5290" }
        }
    }

    FontLoader {
        id: weatherFont
        source: "file:///usr/lib/fonts/weathericons-regular-webfont.ttf"
    }

    ConfigurationValue {
        id: cityName
        key: "/org/asteroidos/weather/city-name"
        defaultValue: qsTr("Unknown")
    }

    Text {
        visible: availableDays(timestampDay0.value*1000) > 0
        text: cityName.value
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height/3
        font.pixelSize: height/6
    }

    ConfigurationValue {
        id: timestampDay0
        key: "/org/asteroidos/weather/timestamp-day0"
        defaultValue: 0
    }

    function dayNbFromIndex(i) {
        var currentDate = new Date();
        var day0Date    = new Date(timestampDay0.value*1000);
        var daysDiff = Math.round((currentDate-day0Date)/(1000*60*60*24));
        if(daysDiff > 5) daysDiff = 5;
        return i+daysDiff;
    }

    function nameOfDay(i) {
        switch(i) {
            case 0:
                return qsTr("Today");
                break;
            case 1:
                return qsTr("Tomorrow");
                break;
            default:
                return Qt.formatDate(new Date(new Date().getTime() + i * 1000*60*60*24), "dddd");
        }
    }

    Component {
        id: dayDelegate
        Item {
            width: app.width; height: app.height
            property int dayNb: dayNbFromIndex(index)

            ConfigurationValue {
                id: owmId
                key: "/org/asteroidos/weather/day" + dayNb + "/id"
                defaultValue: 0
            }
            ConfigurationValue {
                id: minTemp
                key: "/org/asteroidos/weather/day" + dayNb + "/min-temp"
                defaultValue: 0
            }
            ConfigurationValue {
                id: maxTemp
                key: "/org/asteroidos/weather/day" + dayNb + "/max-temp"
                defaultValue: 0
            }

            Text {
                text: nameOfDay(index)
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height/3
                font.pixelSize: height/6
            }

            Text {
                text: "<h6>" + qsTr("Min:") + "</h6>\n" + (minTemp.value-273) + qsTr("°C")
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width/3
                font.pixelSize: width/5
            }

            Text {
                text: IconTools.getIconCode(owmId.value, 0)
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "weathericons"
                font.pixelSize: app.height/3
                anchors.centerIn: parent
            }

            Text {
                text: "<h6>" + qsTr("Max:") + "</h6>\n" + (maxTemp.value-273) + qsTr("°C")
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                anchors.right: parent.right
                width: parent.width/3
                font.pixelSize: width/5
            }
        }
    }

    function availableDays(day0) {
        var currentDate = new Date();
        var day0Date    = new Date(day0);
        var daysDiff = Math.round((currentDate-day0Date)/(1000*60*60*24));
        if(daysDiff > 5 || daysDiff < 0) daysDiff = 5;
        return 5-daysDiff;
    }

    ListView {
        id: lv
        anchors.fill:parent
        model: availableDays(timestampDay0.value*1000)
        delegate: dayDelegate
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
    }

    PageDot {
        height: parent.height/35
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height/30
        currentIndex: lv.currentIndex
        dotNumber: availableDays(timestampDay0.value*1000)
    }

    Icon {
        visible: availableDays(timestampDay0.value*1000) <= 0
        color: "white"
        name: "ios-sync"
        anchors.top: parent.top
        anchors.topMargin: Units.dp(16)
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: noDataText
        visible: availableDays(timestampDay0.value*1000) <= 0
        text: qsTr("<h3>No data</h3>\nSync AsteroidOS with your phone.")
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.centerIn: parent
    }
}

