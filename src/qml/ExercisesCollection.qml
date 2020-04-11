/*

# SPDX-FileCopyrightText: (c) 2020 Matthieu Gallien <matthieu_gallien@yahoo.fr>
#
# SPDX-License-Identifier: GPL-3.0-or-later

*/

import QtQuick 2.12
import QtMultimedia 5.12
import QtQuick.Controls 2.5
import org.kde.kirigami 2.5 as Kirigami

Kirigami.Page {
    property int duration: 40

    Button {
        onClicked: {
            if (!soundTimer.running) {
                soundTimer.loopCounter = -4
                smallBeepSound.play()
                soundTimer.running = true
            }
        }
    }

    Label {
        id: timerText

        anchors.centerIn: parent
        text: '00:00'
        font.pointSize: 20

        horizontalAlignment: Text.Right

        Timer {
            id: dateTimer

            interval: 100
            repeat: true
            running: soundTimer.running

            onTriggered: {
                if (soundTimer.loopCounter < 0) {
                    timerText.text = '- 00:0' + Math.abs(soundTimer.loopCounter)
                } else {
                    var date = new Date(0)
                    date.setSeconds(soundTimer.loopCounter % 60)
                    date.setMinutes(soundTimer.loopCounter / 60)
                    var timeString = date.toISOString().substr(14, 5)
                    timerText.text = timeString
                }
            }
        }
    }

    Item {
        id: soundTimerParent

        Audio {
            id: smallBeepSound
            source: "qrc:/sound/double.wav"
            volume: 0.5
        }

        Audio {
            id: longBeepSound
            source: "qrc:/sound/long.wav"
            volume: 0.5
        }

        Audio {
            id: clockSound
            source: "qrc:/sound/clock.wav"
            volume: 0.5
        }

        Timer {
            id: soundTimer

            property int loopCounter: -4

            interval: 1000
            repeat: true
            running: false

            onTriggered: {
                ++loopCounter
                if (loopCounter < 0 || (loopCounter >= duration - 5 && loopCounter < duration)) {
                    smallBeepSound.play()
                } else if (loopCounter == 0) {
                    longBeepSound.play()
                } else if (loopCounter == duration) {
                    longBeepSound.play()
                } else if (loopCounter > 0 && loopCounter < duration - 5) {
                    clockSound.play()
                } else {
                    soundTimer.running = false
                }
            }
        }
    }
}
