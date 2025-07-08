#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "clipboardhandler.h"
#include <QQuickStyle>
#include <QMenuBar>
#include <QMenu>
#include <QAction>
#include <QMessageBox>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    // Set the Material style and a dark theme
    QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;

    ClipboardHandler clipboardHandler;
    engine.rootContext()->setContextProperty("clipboardHandler", &clipboardHandler);
    engine.addImageProvider(QLatin1String("clipboard"), new ClipboardImageProvider);

    // Create menu bar
    QMenuBar *menuBar = new QMenuBar();

    // Edit Menu
    QMenu *editMenu = menuBar->addMenu("&Edit");
    QAction *copyAction = new QAction("Copy", &app);
    copyAction->setShortcut(QKeySequence::Copy);
    editMenu->addAction(copyAction);
    QObject::connect(copyAction, &QAction::triggered, [&]() {
        QVariant returnedValue;
        QMetaObject::invokeMethod(engine.rootObjects().first(), "copyCanvas",
                                  Q_RETURN_ARG(QVariant, returnedValue));
    });

    QAction *pasteAction = new QAction("Paste", &app);
    pasteAction->setShortcut(QKeySequence::Paste);
    editMenu->addAction(pasteAction);
    QObject::connect(pasteAction, &QAction::triggered, &clipboardHandler, &ClipboardHandler::paste);

    // Help Menu
    QMenu *helpMenu = menuBar->addMenu("&Help");
    QAction *aboutAction = new QAction("About", &app);
    helpMenu->addAction(aboutAction);
    QObject::connect(aboutAction, &QAction::triggered, [&]() {
        QMessageBox::about(nullptr, "About Simple Draw", "Simple drawing application using Qt/QML.");
    });

    const QUrl url(QStringLiteral("qrc:/AppWindow.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

