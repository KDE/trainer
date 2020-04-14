# SPDX-FileCopyrightText: (c) 2020 Matthieu Gallien <matthieu_gallien@yahoo.fr>
#
# SPDX-License-Identifier: GPL-3.0-or-later

cmake_minimum_required(VERSION 3.8)

project(trainer
    VERSION 0.1
    LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)

set(REQUIRED_QT_VERSION "5.12.0")
find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Core Qml Quick Test Multimedia Gui QuickTest QuickControls2 TextToSpeech)

set(REQUIRED_KF5_VERSION "5.60.0")
find_package(ECM ${REQUIRED_KF5_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake" ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
include(ECMInstallIcons)
include(FeatureSummary)
include(ECMAddAppIcon)
include(ECMAddTests)
include(ECMQtDeclareLoggingCategory)

find_package(Qt5QuickWidgets ${REQUIRED_QT_VERSION} CONFIG QUIET)
set_package_properties(Qt5QuickWidgets PROPERTIES
    DESCRIPTION "Qt5 Quick Widgets is needed at runtime to provide the interface."
    TYPE REQUIRED)

find_package(Qt5QuickControls2 ${REQUIRED_QT_VERSION} CONFIG QUIET)
set_package_properties(Qt5QuickControls2 PROPERTIES
    DESCRIPTION "Qt5 Quick Controls version 2 is needed at runtime to provide the interface."
    TYPE REQUIRED)

find_package(KF5Kirigami2 ${REQUIRED_KF5_VERSION} CONFIG QUIET)
set_package_properties(KF5Kirigami2 PROPERTIES
    DESCRIPTION "KF5 Kirigami 2 is needed to provide the mobile UI components."
    TYPE REQUIRED)

find_package(KF5I18n ${REQUIRED_KF5_VERSION} CONFIG QUIET)
set_package_properties(KF5I18n PROPERTIES
    DESCRIPTION "KF5 text internationalization library."
    TYPE REQUIRED)

find_package(KF5Declarative ${REQUIRED_KF5_VERSION} CONFIG QUIET)
set_package_properties(KF5Declarative PROPERTIES
    DESCRIPTION "Integration of QML and KDE work spaces."
    TYPE REQUIRED)

find_package(KF5Config ${REQUIRED_KF5_VERSION} CONFIG QUIET)
set_package_properties(KF5Config PROPERTIES
    DESCRIPTION "Persistent platform-independent application settings."
    TYPE REQUIRED)

find_package(KF5Crash ${REQUIRED_KF5_VERSION} CONFIG QUIET)
set_package_properties(KF5Crash PROPERTIES
    DESCRIPTION "Graceful handling of application crashes."
    TYPE REQUIRED)

include(FeatureSummary)
include(GenerateExportHeader)
include(ECMSetupVersion)
include(ECMGenerateHeaders)
include(CMakePackageConfigHelpers)

add_subdirectory(src)
if (BUILD_TESTING)
    add_subdirectory(autotests)
endif()

install(
    PROGRAMS org.kde.trainer.desktop
    DESTINATION ${XDG_APPS_INSTALL_DIR}
)

install(
    FILES org.kde.trainer.appdata.xml
    DESTINATION ${KDE_INSTALL_METAINFODIR}
)

ki18n_install(po)

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
