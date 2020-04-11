/*

# SPDX-FileCopyrightText: (c) 2020 Matthieu Gallien <matthieu_gallien@yahoo.fr>
#
# SPDX-License-Identifier: GPL-3.0-or-later

*/

import QtQuick 2.12
import QtQuick.Controls 2.5
import org.kde.kirigami 2.5 as Kirigami

Kirigami.Page {
    Button {
        text: i18n("Start")
        enabled: !soundTimer.running

        onClicked: {
            if (!soundTimer.running) {
                soundTimer.start()
            }
        }
    }

    SoundTimer {
        id: soundTimer
    }

    TimeDisplay {
        id: timeDisplay

        time: soundTimer.currentTime
    }
}
