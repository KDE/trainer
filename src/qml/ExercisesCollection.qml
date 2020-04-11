/*

# SPDX-FileCopyrightText: (c) 2020 Matthieu Gallien <matthieu_gallien@yahoo.fr>
#
# SPDX-License-Identifier: GPL-3.0-or-later

*/

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.5 as Kirigami

Kirigami.Page {
    mainAction: Kirigami.Action {
        text: i18n("Start")
        iconName: "play"
        enabled: !soundTimer.running
        onTriggered: {
            if (!soundTimer.running) {
                soundTimer.start()
                reportProgressDrawer.open()
            }
        }
    }

    ListView {
        anchors.fill: parent

        header: Kirigami.ItemViewHeader {
            title: i18n("List of Exercises")
        }

        model: exercisesModel

        delegate: Kirigami.BasicListItem {
            text: model.name
        }
    }

    ListModel {
        id: exercisesModel

        Component.onCompleted: {
            append({name: i18n("Do push-ups")})
            append({name: i18n("Plank")})
            append({name: i18n("Left side plank")})
            append({name: i18n("Right side plank")})
            append({name: i18n("Extended plank")})
            append({name: i18n("Crunch")})
            append({name: i18n("Bicycle crunch")})
        }
    }

    Drawer {
        id: reportProgressDrawer

        width: parent.width
        height: parent.height * 0.75

        edge: Qt.BottomEdge
        interactive: false

        ColumnLayout {
            anchors.fill: parent

            TimeDisplay {
                id: timeDisplay

                time: soundTimer.currentTime

                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            Button {
                text: i18n("Stop")

                onClicked: {
                    soundTimer.stop()
                    reportProgressDrawer.close()
                }

                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            }
        }

        SoundTimer {
            id: soundTimer
        }
    }
}
