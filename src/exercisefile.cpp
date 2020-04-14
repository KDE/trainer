/*

# SPDX-FileCopyrightText: (c) 2020 Matthieu Gallien <matthieu_gallien@yahoo.fr>
#
# SPDX-License-Identifier: GPL-3.0-or-later

*/

#include "exercisefile.h"

ExerciseFile::ExerciseFile(QObject *parent) : QObject(parent)
{

}

bool ExerciseFile::isValid() const
{
    return mIsValid;
}

QString ExerciseFile::data()
{
    return QString::fromLocal8Bit(mFile.readAll());
}

void ExerciseFile::setName(QUrl name)
{
    if (name == mName) {
        return;
    }

    mName = std::move(name);
    Q_EMIT nameChanged();

    if (mName.isLocalFile()) {
        mFileInfo.setFile(mName.toLocalFile());

        if (!mFileInfo.exists() || !mFileInfo.isFile() || !mFileInfo.isReadable()) {
            mIsValid = false;
            Q_EMIT isValidChanged();

            return;
        }

        mFile.setFileName(mFileInfo.canonicalFilePath());
        mIsValid = mFile.open(QIODevice::ReadOnly | QIODevice::Text);

        Q_EMIT isValidChanged();
        Q_EMIT dataChanged();
    } else if (mName.scheme() == QStringLiteral("qrc")) {
        mFile.setFileName(QStringLiteral(":%1").arg(mName.path()));
        mIsValid = mFile.open(QIODevice::ReadOnly | QIODevice::Text);

        Q_EMIT isValidChanged();
        Q_EMIT dataChanged();
    }
}


#include "moc_exercisefile.cpp"
