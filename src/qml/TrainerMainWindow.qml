/*

# SPDX-FileCopyrightText: (c) 2020 Matthieu Gallien <matthieu_gallien@yahoo.fr>
#
# SPDX-License-Identifier: GPL-3.0-or-later

*/

import QtQuick 2.12
import QtQuick.Controls 2.5
import org.kde.kirigami 2.5 as Kirigami

Kirigami.ApplicationWindow {
    id: mainWindow
    
    visible: true
    
    LayoutMirroring.enabled: Qt.application.layoutDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    title: i18n("Trainer")

    Accessible.role: Accessible.Application
    Accessible.name: title

    globalDrawer: Kirigami.GlobalDrawer {
        title: mainWindow.title

        actions: [
           Kirigami.Action {
               text: "View"
               iconName: "view-list-icons"
               Kirigami.Action {
                       text: "action 1"
               }
               Kirigami.Action {
                       text: "action 2"
               }
               Kirigami.Action {
                       text: "action 3"
               }
           },
           Kirigami.Action {
               text: "Sync"
               iconName: "folder-sync"
           }
        ]
    }

    contextDrawer: Kirigami.ContextDrawer {
        id: contextDrawer
    }

    pageStack.initialPage: Kirigami.Page {
        mainAction: Kirigami.Action {
            iconName: "edit"
            onTriggered: {
                // do stuff
            }
        }
        contextualActions: [
            Kirigami.Action {
                iconName: "edit"
                text: "Action text"
                onTriggered: {
                    // do stuff
                }
            },
            Kirigami.Action {
                iconName: "edit"
                text: "Action text"
                onTriggered: {
                    // do stuff
                }
            }
        ]
    }
}
