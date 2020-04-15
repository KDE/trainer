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
import org.kde.trainer 1.0 as Trainer

Kirigami.ScrollablePage {
    property alias exerciseFilename: file.name

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
    }

    Trainer.ExerciseFile {
        id: file
    }

    ExercisesRunnerDrawer {
        id: reportProgressDrawer

        exercisesListModel: exercisesModel

        edge: Qt.BottomEdge
        interactive: false

        width: parent.width
        height: parent.height * 0.85
    }

    Component.onCompleted: {
        if (file.isValid) {
            let json = JSON.parse(file.data)
            json.steps.forEach(function(oneExercise) {
                exercisesModel.append(oneExercise)
            })
        }
    }
}
