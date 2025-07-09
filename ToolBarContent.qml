import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

RowLayout {
    spacing: 10
    anchors.fill: parent

    property string currentTool: "pen"
    property color currentColor: "blue"
    property var colorPalettePopup: null
    signal toolSelected(string tool)
    signal colorSelected(color color)

    ToolButton {
        icon.source: "qrc:/icons/pen.svg"
        text: "Pen"
        display: AbstractButton.TextUnderIcon
        implicitWidth: 64
        implicitHeight: 48
        onClicked: {
            currentTool = "pen"
            toolSelected(currentTool)
        }
    }

    ToolButton {
        icon.source: "qrc:/icons/square.svg"
        text: "Square"
        display: AbstractButton.TextUnderIcon
        implicitWidth: 64
        implicitHeight: 48
        onClicked: {
            currentTool = "square"
            toolSelected(currentTool)
        }
    }

    ToolButton {
        icon.source: "qrc:/icons/circle.svg"
        text: "Circle"
        display: AbstractButton.TextUnderIcon
        implicitWidth: 64
        implicitHeight: 48
        onClicked: {
            currentTool = "circle"
            toolSelected(currentTool)
        }
    }

    ToolButton {
        icon.source: "qrc:/icons/line.svg"
        text: "Line"
        display: AbstractButton.TextUnderIcon
        implicitWidth: 64
        implicitHeight: 48
        onClicked: {
            currentTool = "line"
            toolSelected(currentTool)
        }
    }

    ToolButton {
        icon.source: "qrc:/icons/erase.svg"
        text: "Erase"
        display: AbstractButton.TextUnderIcon
        implicitWidth: 64
        implicitHeight: 48
        onClicked: {
            currentTool = "erase"
            toolSelected(currentTool)
        }
    }

    ToolButton {
        icon.source: "qrc:/icons/text.svg"
        text: "Text"
        display: AbstractButton.TextUnderIcon
        implicitWidth: 64
        implicitHeight: 48
        onClicked: {
            currentTool = "text"
            toolSelected(currentTool)
        }
    }

    Rectangle {
        width: 24
        height: 24
        color: currentColor
        border.color: "black"
        border.width: 1
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (colorPalettePopup) {
                    colorPalettePopup.open()
                }
            }
        }
    }

    ToolButton {
        text: "Colors"
        display: AbstractButton.TextUnderIcon
        implicitWidth: 64
        implicitHeight: 48
        onClicked: {
            if (colorPalettePopup) {
                colorPalettePopup.open()
            }
        }
    }
}
