/*

# SPDX-FileCopyrightText: (c) 2020 Matthieu Gallien <matthieu_gallien@yahoo.fr>
#
# SPDX-License-Identifier: GPL-3.0-or-later

*/

#ifndef EXERCISEFILE_H
#define EXERCISEFILE_H

#include <QObject>
#include <QUrl>
#include <QFile>
#include <QFileInfo>

class ExerciseFile : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QUrl name READ name WRITE setName NOTIFY nameChanged)

    Q_PROPERTY(bool isValid READ isValid NOTIFY isValidChanged)

    Q_PROPERTY(QString data READ data NOTIFY dataChanged)
public:
    explicit ExerciseFile(QObject *parent = nullptr);

    [[nodiscard]] QUrl name() const
    {
        return mName;
    }

    [[nodiscard]] bool isValid() const;

    [[nodiscard]] QString data();

Q_SIGNALS:

    void nameChanged();

    void isValidChanged();

    void dataChanged();

public Q_SLOTS:

    void setName(QUrl name);

private:

    QUrl mName;

    QFile mFile;

    QFileInfo mFileInfo;

    bool mIsValid = false;

};

#endif // EXERCISEFILE_H
