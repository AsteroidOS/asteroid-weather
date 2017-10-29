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

import QtQuick 2.9
import org.asteroid.controls 1.0
import org.nemomobile.configuration 1.0
import 'qrc:/icons.js' as IconTools

Application {
    id: app

    centerColor: "#C91C1C"
    outerColor: "#4C0000"

    FontLoader {
        id: weatherFont
        source: "file:///usr/share/fonts/weathericons-regular-webfont.ttf"
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
        height: Dims.h(33)
        font.pixelSize: Dims.l(6)
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

    ConfigurationValue {
        id: useFahrenheit
        key: "/org/asteroidos/settings/use-fahrenheit"
        defaultValue: false
    }

    function convertTemp(val) {
        var celsius = (val-273);
        if(!useFahrenheit.value)
            return celsius + "°C";
        else
            return (((celsius)*9/5) + 32) + "°F";
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
                height: Dims.h(33)
                font.pixelSize: Dims.l(6)
            }

            Text {
                text: "<h6>" + qsTr("Min:") + "</h6>\n" + convertTemp(minTemp.value)
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                anchors.left: parent.left
                width: Dims.w(33)
                font.pixelSize: Dims.l(7)
            }

            Text {
                text: IconTools.getIconCode(owmId.value, 0)
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "weathericons"
                font.pixelSize: Dims.l(33)
                anchors.centerIn: parent
            }

            Text {
                text: "<h6>" + qsTr("Max:") + "</h6>\n" + convertTemp(maxTemp.value)
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                anchors.right: parent.right
                width: Dims.w(33)
                font.pixelSize: Dims.l(6)
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
        height: Dims.h(3)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Dims.h(3)
        currentIndex: lv.currentIndex
        dotNumber: availableDays(timestampDay0.value*1000)
    }

    Rectangle {
        id: noDataBackground
        visible: availableDays(timestampDay0.value*1000) <= 0
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -Dims.h(13)
        color: "black"
        radius: width/2
        opacity: 0.2
        width: parent.height*0.25
        height: width
    }
    Icon {
        visible: availableDays(timestampDay0.value*1000) <= 0
        anchors.fill: noDataBackground
        anchors.margins: Dims.l(3)
        color: "white"
        name: "ios-sync"
    }

    Text {
        id: noDataText
        visible: availableDays(timestampDay0.value*1000) <= 0
        text: qsTr("<h3>No data</h3>\nSync AsteroidOS with your phone.")
        font.pixelSize: Dims.l(5)
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.Wrap
        anchors.left: parent.left; anchors.right: parent.right
        anchors.leftMargin: Dims.w(2); anchors.rightMargin: Dims.w(2)
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: Dims.h(15)
    }
}

