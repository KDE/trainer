# SPDX-FileCopyrightText: (c) 2020 Matthieu Gallien <matthieu_gallien@yahoo.fr>
#
# SPDX-License-Identifier: GPL-3.0-or-later

include_directories(${trainer_BINARY_DIR})

set(trainer_SOURCES
    main.cpp

    qml/TrainerMainWindow.qml
)

qt5_add_resources(trainer_SOURCES resources.qrc)
set_property(SOURCE qrc_resources.cpp PROPERTY SKIP_AUTOMOC ON)

add_executable(trainer ${trainer_SOURCES})

target_link_libraries(trainer
    LINK_PRIVATE
    Qt5::Gui
    Qt5::QuickControls2
    KF5::I18n
    KF5::ConfigCore
    KF5::Crash
    KF5::Declarative
    )

set(QML_IMPORT_PATH ${CMAKE_BINARY_DIR}/bin CACHE INTERNAL "qml import path" FORCE)

if (ANDROID)
    kirigami_package_breeze_icons(ICONS trainer)
endif()
