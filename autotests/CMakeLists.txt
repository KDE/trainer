# SPDX-FileCopyrightText: (c) 2020 Matthieu Gallien <matthieu_gallien@yahoo.fr>
#
# SPDX-License-Identifier: GPL-3.0-or-later

enable_testing()

set(trainerqmltests_SOURCES
    trainerqmltests.cpp
)

ecm_add_test(${trainerqmltests_SOURCES}
    TEST_NAME "trainerqmltests"
    LINK_LIBRARIES Qt5::Core Qt5::Widgets Qt5::Test Qt5::QuickTest
    GUI)

target_compile_definitions(trainerqmltests PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_SOURCE_DIR}/autotests/qmltests")

target_include_directories(trainerqmltests PRIVATE ${CMAKE_SOURCE_DIR}/src)

