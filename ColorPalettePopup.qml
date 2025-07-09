import QtQuick 2.15
import QtQuick.Controls 2.15

Popup {
    id: colorPalettePopup
    x: parent.width / 2 - width / 2
    y: 40 + 10 // toolBar.height + 10
    width: 200
    height: 200
    modal: true
    focus: true
    padding: 0

    property color currentColor: "blue"
    property var colorPalette: [
        "#000000", "#333333", "#666666", "#999999", "#CCCCCC", "#EEEEEE", "#FFFFFF", "#FF0000",
        "#FF3300", "#FF6600", "#FF9900", "#FFCC00", "#FFFF00", "#CCFF00", "#99FF00", "#66FF00",
        "#33FF00", "#00FF00", "#00FF33", "#00FF66", "#00FF99", "#00FFCC", "#00FFFF", "#00CCFF",
        "#0099FF", "#0066FF", "#0033FF", "#0000FF", "#3300FF", "#6600FF", "#9900FF", "#CC00FF",
        "#FF00FF", "#FF00CC", "#FF0099", "#FF0066", "#FF0033", "#800000", "#803300", "#806600",
        "#809900", "#80CC00", "#80FF00", "#408000", "#008000", "#008040", "#008080", "#004080",
        "#000080", "#400080", "#800080", "#800040", "#8000FF", "#4000FF", "#0000FF", "#0040FF",
        "#0080FF", "#00FF80", "#00FF40", "#40FF00", "#80FF40", "#FF8000", "#FF4000", "#FF0080"
    ]

    signal colorChanged(color color)
    signal colorSelected(color color)

    GridView {
        id: colorGrid
        anchors.fill: parent
        cellWidth: 25
        cellHeight: 25
        model: colorPalette ? colorPalette.length : 0

        delegate: Rectangle {
            width: colorGrid.cellWidth
            height: colorGrid.cellHeight
            color: colorPalette[index]
            border.color: "black"
            border.width: 1

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (currentColor !== colorPalette[index]) {
                        currentColor = colorPalette[index]
                        colorChanged(currentColor)
                        colorSelected(currentColor)
                    }
                    colorPalettePopup.close()
                }
            }
        }
    }
}