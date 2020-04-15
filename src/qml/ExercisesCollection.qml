/*

# SPDX-FileCopyrightText: (c) 2020 Matthieu Gallien <matthieu_gallien@yahoo.fr>
#
# SPDX-License-Identifier: GPL-3.0-or-later

*/

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQml.Models 2.12
import org.kde.kirigami 2.10 as Kirigami
import org.kde.trainer 1.0 as Trainer

Kirigami.ScrollablePage {
    ListView {
        anchors.fill: parent

        header: Kirigami.ItemViewHeader {
            title: i18n("List of Exercises")
        }

        model: exercisesModel

        delegate: Kirigami.BasicListItem {
            text: model.name

            onClicked: {
                applicationWindow().pageStack.push(newPageComponent, {exerciseFilename: model.fileName})
            }
        }
    }

    ListModel {
        id: exercisesModel

        Component.onCompleted: {
            append({
                       name: 'Simple exercise',
                       fileName: Qt.resolvedUrl('/data/simple.json')
                   })
            append({
                       name: 'Short exercise',
                       fileName: Qt.resolvedUrl('/data/short.json')
                   })
        }
    }

    Component {
        id: newPageComponent

        OneExercise {
        }
    }
}
