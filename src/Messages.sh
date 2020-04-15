#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2020 (c) 2020 Matthieu Gallien <matthieu_gallien@yahoo.fr>
#
# SPDX-License-Identifier: GPL-3.0-or-later

$XGETTEXT $(find . \( -name \*.qml -o -name \*.cpp -o -name \*.h \)) -o $podir/trainer.pot
