QT += quick quickcontrols2 widgets
QT -= sql

SOURCES += \
    main.cpp \
    clipboardhandler.cpp

HEADERS += \
    clipboardhandler.h

RESOURCES += \
    qml.qrc

# Additional import path so that QML imports work correctly
QML_IMPORT_PATH = 
QT_QML_GENERATE_QMLLS_INI = true
