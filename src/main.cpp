/*

# SPDX-FileCopyrightText: (c) 2020 Matthieu Gallien <matthieu_gallien@yahoo.fr>
#
# SPDX-License-Identifier: GPL-3.0-or-later

*/

//#define QT_QML_DEBUG

#include "exercisefile.h"

#include <KDeclarative/KDeclarative>
#include <KQuickAddons/QtQuickSettings>

#include <KI18n/KLocalizedString>
#include <KI18n/KLocalizedContext>

#include <KCoreAddons/KAboutData>

#include <KCrash>

#include <QGuiApplication>
#include <QCommandLineParser>
#include <QStandardPaths>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlFileSelector>
#include <QQuickStyle>
#include <QQmlContext>
#include <QTextToSpeech>

#if defined Q_OS_ANDROID
int __attribute__((visibility("default"))) main(int argc, char *argv[])
#else
int main(int argc, char *argv[])
#endif
{
#if defined Q_OS_ANDROID
    if(argc > 1 && strcmp(argv[1], "-service") == 0){
        QAndroidService app(argc, argv);
        qInfo() << "Service starting...";

        // My service stuff

        return app.exec();
    }

    qInfo() << "Application starting...";
#endif

    QGuiApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    //KQuickAddons::QtQuickSettings::init();

    KLocalizedString::setApplicationDomain("elisa");

    KCrash::initialize();

    QGuiApplication::setWindowIcon(QIcon::fromTheme(QStringLiteral("trainer")));

    KAboutData aboutData( QStringLiteral("trainer"),
                          i18n("Trainer"),
                          QStringLiteral("0.1"),
                          i18n("A Simple Sport Trainer companion application made with love by the KDE community"),
                          KAboutLicense::GPL_V3,
                          i18n("(c) 2020, Trainer contributors"));

    aboutData.addAuthor(QStringLiteral("Matthieu Gallien"),i18n("Creator"), QStringLiteral("mgallien@mgallien.fr"));

    KAboutData::setApplicationData(aboutData);

    QCommandLineParser parser;
    aboutData.setupCommandLine(&parser);
    parser.process(app);
    aboutData.processCommandLine(&parser);

    QQuickStyle::setStyle(QStringLiteral("org.kde.desktop"));
    QQuickStyle::setFallbackStyle(QStringLiteral("Fusion"));

    QQmlApplicationEngine engine;
    engine.addImportPath(QStringLiteral("qrc:/imports"));
    QQmlFileSelector selector(&engine);

    KDeclarative::KDeclarative decl;
    decl.setDeclarativeEngine(&engine);
    decl.setupEngine(&engine);
    decl.setupContext();

    qmlRegisterType<QTextToSpeech>("org.kde.trainer", 1, 0, "TextToSpeech");
    qmlRegisterType<ExerciseFile>("org.kde.trainer", 1, 0, "ExerciseFile");

    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));

    engine.load(QUrl(QStringLiteral("qrc:/qml/TrainerMainWindow.qml")));

    return app.exec();
}
