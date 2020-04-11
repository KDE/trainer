#!/usr/bin/env bash

$XGETTEXT $(find . -a \( -name \*.qml -o -name \*.cpp -o -name \*.h \)) -o $podir/trainer.pot
