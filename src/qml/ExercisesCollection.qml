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

Kirigami.Page {
    mainAction: Kirigami.Action {
        text: i18n("Start")
        iconName: "play"
        enabled: !reportProgressDrawer.running
        onTriggered: {
            if (!reportProgressDrawer.running) {
                reportProgressDrawer.start()
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
            append({name: i18n("Do push-ups"), duration: 40})
            append({name: i18n("Plank"), duration: 40})
            append({name: i18n("Left side plank"), duration: 40})
            append({name: i18n("Right side plank"), duration: 40})
            append({name: i18n("Extended plank"), duration: 40})
            append({name: i18n("Crunch"), duration: 40})
            append({name: i18n("Bicycle crunch"), duration: 40})
        }
    }

    ExercisesRunnerDrawer {
        id: reportProgressDrawer

        exercisesListModel: exercisesModel

        edge: Qt.BottomEdge
        interactive: false

        width: parent.width
        height: parent.height * 0.85
    }
}
