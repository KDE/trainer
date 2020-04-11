/*

# SPDX-FileCopyrightText: (c) 2020 Matthieu Gallien <matthieu_gallien@yahoo.fr>
#
# SPDX-License-Identifier: GPL-3.0-or-later

*/

import QtQuick 2.12
import QtMultimedia 5.12

Item {
    property alias currentTime: internalTimer.loopCounter
    property int duration: 40

    function start() {
        internalTimer.loopCounter = -4
        smallBeepSound.play()
        internalTimer.running = true
    }

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
        id: internalTimer

        property int loopCounter: 0

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
                internalTimer.running = false
            }
        }
    }
}
