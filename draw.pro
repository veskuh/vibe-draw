QT += quick quickcontrols2 widgets
QT -= sql

SOURCES += \
    main.cpp \
    clipboardhandler.cpp

HEADERS += \
    clipboardhandler.h

RESOURCES += \
    qml.qrc

ICON = icons/app-icon.icns
RC_FILE = icons/app-icon.icns
QMAKE_INFO_PLIST = Info.plist

# Additional import path so that QML imports work correctly
QML_IMPORT_PATH = 
QT_QML_GENERATE_QMLLS_INI = true
