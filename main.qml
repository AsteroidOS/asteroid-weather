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

    function availableDays(day0) {
        var currentDate = new Date();
        var day0Date    = new Date(day0);
        var daysDiff = Math.round((currentDate-day0Date)/(1000*60*60*24));
        if(daysDiff > 5 || daysDiff < 0) daysDiff = 5;
        return 5-daysDiff;
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

    function convertTemp(val) {
        var celsius = (val-273);
        if(!useFahrenheit.value)
            return celsius + "°C";
        else
            return Math.round((((celsius)*9/5) + 32) * 10) / 10 + "°F";
    }

    ConfigurationValue {
        id: timestampDay0
        key: "/org/asteroidos/weather/timestamp-day0"
        defaultValue: 0
    }

    ConfigurationValue {
        id: useFahrenheit
        key: "/org/asteroidos/settings/use-fahrenheit"
        defaultValue: false
    }

    ConfigurationValue {
        id: cityName
        key: "/org/asteroidos/weather/city-name"
        defaultValue: qsTr("Unknown")
    }

    StatusPage {
        text: qsTr("<h3>No data</h3>\nSync AsteroidOS with your phone.")
        icon: "ios-sync"
        visible: availableDays(timestampDay0.value*1000) <= 0
    }
    Item {
        anchors.fill: parent

        visible: availableDays(timestampDay0.value*1000) > 0

        Label {
            text: cityName.value
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: Dims.h(33)
            font.pixelSize: Dims.l(6)
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

                Label {
                    text: nameOfDay(index)
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: Dims.h(33)
                    font.pixelSize: Dims.l(6)
                    font.bold: true
                }

                Label {
                    text: "<h6>" + qsTr("Min:") + "</h6>\n" + convertTemp(minTemp.value)
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    anchors.left: parent.left
                    width: Dims.w(33)
                }

                Icon {
                    name: IconTools.getIconName(owmId.value)
                    anchors.centerIn: parent
                    width: Dims.w(33)
                    height: width
                }

                Label {
                    text: "<h6>" + qsTr("Max:") + "</h6>\n" + convertTemp(maxTemp.value)
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
    }
}

