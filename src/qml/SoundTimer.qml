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
    property int beforeEndDuration: 5
    property int preparingDuration: 5
    property int silentPreparingDuration: 0
    property alias running: internalTimer.running

    signal finished()

    function start() {
        internalTimer.loopCounter = 1 - preparingDuration - silentPreparingDuration

        if (!silentPreparingDuration) {
            smallBeepSound.play()
        }

        internalTimer.start()
    }

    function stop() {
        internalTimer.stop()
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
            if (loopCounter < duration) {
                ++loopCounter
            } else {
                internalTimer.running = false
                finished()
                return
            }

            if ((loopCounter >= -preparingDuration && loopCounter < 0) || (loopCounter >= duration - beforeEndDuration && loopCounter < duration)) {
                smallBeepSound.play()
            } else if (loopCounter == 0) {
                longBeepSound.play()
            } else if (loopCounter == duration) {
                longBeepSound.play()
            } else if (loopCounter > 0 && loopCounter < duration - beforeEndDuration) {
                clockSound.play()
            }
        }
    }
}
