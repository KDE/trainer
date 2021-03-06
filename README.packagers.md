<!---
# SPDX-FileCopyrightText: (c) 2020 Matthieu Gallien <matthieu_gallien@yahoo.fr>
#
# SPDX-License-Identifier: GPL-3.0-or-later
-->

# Dependencies

Trainer has the following dependencies:

## REQUIRED:

 * Qt5Qml
 * Qt5Quick
 * Qt5Test
 * Qt5Multimedia
 * Qt5Gui
 * Qt5QuickTest
 * Qt5 (required version >= 5.14.0)
 * Qt5QuickControls2 (required version >= 5.10.0), Qt5 Quick Controls version 2 is needed at runtime to provide the interface.
 * KF5Kirigami2 (required version >= 5.48.0), KF5 Kirigami 2 is needed to provide the mobile UI components.
 * Gettext
 * KF5I18n (required version >= 5.48.0), KF5 text internationalization library.
 * KF5Config (required version >= 5.48.0), Persistent platform-independent application settings.
 * ECM (required version >= 1.6.0)

Please consider packaging Trainer with all its recommended dependencies. Even if they are not required, a nice fallback is not always implemented and user experience may suffer a lot.

Thanks in advance for your work.

# Build instructions

Trainer can be compiled like any other CMake project:

```
$ cmake -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr
$ cmake --build build
$ DESTDIR="/path/to/install/to" cmake --build build --target install
```

Tests can be ran too:

```
$ cd build
$ xvfb-run ctest
```
