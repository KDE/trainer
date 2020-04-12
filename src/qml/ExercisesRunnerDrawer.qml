/*

# SPDX-FileCopyrightText: (c) 2020 Matthieu Gallien <matthieu_gallien@yahoo.fr>
#
# SPDX-License-Identifier: GPL-3.0-or-later

*/

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQml.Models 2.12
import org.kde.kirigami 2.5 as Kirigami

Drawer {
    id: theDrawer

    property alias running: soundTimer.running

    property ListModel exercisesListModel
    property int currentExerciseIndex: 0
    property string exerciseName: ''

    function start() {
        if (!exercisesListModel.count) {
            return
        }

        currentExerciseIndex = 0

        startOneExercise()
    }

    function startOneExercise() {
        if (!currentExerciseIndex) {
            soundTimer.preparingDuration = 5
            soundTimer.silentPreparingDuration = 0
        } else {
            soundTimer.preparingDuration = 5
            soundTimer.silentPreparingDuration = 55
        }

        soundTimer.duration = exercisesListModel.get(currentExerciseIndex).duration
        exerciseName = exercisesListModel.get(currentExerciseIndex).name
        soundTimer.start()
    }

    ColumnLayout {
        anchors.fill: parent

        TimeDisplay {
            id: timeDisplay

            time: soundTimer.currentTime

            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        Kirigami.Heading {
            id: exerciseNameLabel

            text: i18n("Exercise: %1", exerciseName)

            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        Kirigami.Heading {
            id: currentExerciseIndexLabel

            text: i18n("%1 / %2", currentExerciseIndex + 1, exercisesListModel.count)

            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        Button {
            text: i18n("Stop")

            onClicked: {
                soundTimer.stop()
                reportProgressDrawer.close()
            }

            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.bottomMargin: Kirigami.Units.largeSpacing
        }
    }

    SoundTimer {
        id: soundTimer

        onFinished: {
            if (currentExerciseIndex < exercisesListModel.count) {
                ++currentExerciseIndex
                startOneExercise()
            } else {
                theDrawer.close()
            }
        }
    }
}
