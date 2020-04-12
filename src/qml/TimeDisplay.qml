/*

# SPDX-FileCopyrightText: (c) 2020 Matthieu Gallien <matthieu_gallien@yahoo.fr>
#
# SPDX-License-Identifier: GPL-3.0-or-later

*/

import QtQuick 2.12
import QtQuick.Controls 2.5

Label {
    id: timerText

    property int time: 0

    text: '00:00'
    font.pointSize: 20

    horizontalAlignment: Text.Right

    onTimeChanged: onChangeEffect.restart()

    SequentialAnimation {
        id: onChangeEffect

        ScaleAnimator {
            target: timerText
            from: 1
            to: 1.1
            duration: 150
        }
        ScaleAnimator {
            target: timerText
            from: 1.1
            to: 1.
            duration: 80
        }
    }

    Timer {
        id: dateTimer

        interval: 100
        repeat: true
        running: true

        onTriggered: {
            if (timerText.time < 0 && timerText.time > -60) {
                let date = new Date(0)
                date.setSeconds(Math.abs(timerText.time))
                let timeString = date.toISOString().substr(14, 5)
                timerText.text = timeString
                timerText.text = '- ' + timeString
            } else {
                let date = new Date(0)
                date.setSeconds(timerText.time % 60)
                date.setMinutes(timerText.time / 60)
                let timeString = date.toISOString().substr(14, 5)
                timerText.text = timeString
            }
        }
    }
}
