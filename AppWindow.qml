import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    width: 800
    height: 600
    visible: true
    title: "Simple Draw"

    property string currentTool: "pen"
    property color currentColor: "blue"
    property var currentShape: null
    property var shapes: []

    function copyCanvas() {
        var dataUrl = canvasArea.canvas.toDataURL("image/png");
        clipboardHandler.copyImage(dataUrl);
    }

    Component.onCompleted: {
        canvasArea.setShapes(shapes);
    }

    header: ToolBar {
        id: toolBar
        height: 40

        ToolBarContent {
            id: toolBarContent
            anchors.fill: parent
            currentTool: window.currentTool
            currentColor: window.currentColor
            colorPalettePopup: window.colorPalettePopup

            Connections {
                target: colorPalettePopup
                function onColorChanged(color) { currentColor = color }
            }
            onCurrentColorChanged: {
                window.currentColor = currentColor
            }
            onCurrentToolChanged: {
                window.currentTool = currentTool
            }
        }
    }

    CanvasArea {
            id: canvasArea
            anchors.fill: parent
            currentTool: window.currentTool
            currentColor: window.currentColor
            onShapesUpdated: function(newShapes) {
                if (shapes !== newShapes) shapes = newShapes;
                canvasArea.setShapes(shapes);
            }
        }

    ColorPalettePopup {
        id: colorPalettePopup
        currentColor: currentColor
    }
}