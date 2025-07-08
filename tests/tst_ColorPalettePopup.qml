import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Test 1.2

TestCase {
    name: "ColorPalettePopup"
    when: windowShown(colorPalettePopup)

    Popup {
        id: colorPalettePopup
        x: 0
        y: 0
        width: 200
        height: 200
        modal: true
        focus: true

        property color currentColor: "blue"
        property var colorPalette: [
            "#FF0000", "#00FF00", "#0000FF"
        ]

        signal colorChanged(color color)

        background: Rectangle {
            color: "white"
            border.color: "black"
            border.width: 1
        }

        GridView {
            id: colorGrid
            anchors.fill: parent
            cellWidth: 25
            cellHeight: 25
            model: colorPalette.length

            delegate: Rectangle {
                width: colorGrid.cellWidth
                height: colorGrid.cellHeight
                color: colorPalette[index]
                border.color: "black"
                border.width: 1

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        currentColor = colorPalette[index]
                        colorChanged(currentColor)
                        colorPalettePopup.close()
                    }
                }
            }
        }
    }

    function test_colorChanged_signal() {
        verify(colorPalettePopup.currentColor === "blue");

        var receivedColor = "";
        colorPalettePopup.colorChanged.connect(function(color) {
            receivedColor = color;
        });

        // Click on the second color (green)
        mouseClick(colorPalettePopup.colorGrid.itemAt(1).MouseArea);

        verify(receivedColor === "#00FF00");
        verify(colorPalettePopup.currentColor === "#00FF00");
        verify(!colorPalettePopup.visible);
    }
}
