#ifndef EXERCISEFILE_H
#define EXERCISEFILE_H

#include <QObject>
#include <QUrl>

class ExerciseFile : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QUrl fileName READ fileName WRITE setFileName NOTIFY fileNameChanged)
public:
    explicit ExerciseFile(QObject *parent = nullptr);

    [[nodiscard]] QUrl fileName() const
    {
        return mFileName;
    }

Q_SIGNALS:

    void fileNameChanged();

public Q_SLOTS:

    void setFileName(QUrl name)
    {
        if (name == mFileName) {
            return;
        }

        mFileName = name;
        Q_EMIT fileNameChanged();
    }

private:

    QUrl mFileName;

};

#endif // EXERCISEFILE_H
