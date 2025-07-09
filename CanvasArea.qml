import QtQuick 2.15
import QtQuick.Controls 2.15

Canvas {
    id: canvas
    anchors.fill: parent

    property string currentTool: "pen"
    property color currentColor: "blue"
    property var currentShape: null
    property var shapes: []
    signal shapesUpdated(var newShapes)

    Image {
        id: backgroundImage
        visible: false
    }

    function setShapes(newShapes) {
        shapes = newShapes;
        canvas.requestPaint();
    }

    onPaint: {
        var ctx = getContext("2d");
        ctx.fillStyle = "white";
        ctx.fillRect(0, 0, canvas.width, canvas.height);

        if (backgroundImage.source !== "") {
            ctx.drawImage(backgroundImage, 0, 0)
        }

        if (shapes !== undefined) {
            shapes.forEach(function(shape) {
                ctx.lineWidth = shape.type === "erase" ? 20 : 4;
                ctx.strokeStyle = shape.type === "erase" ? "white" : shape.color;
                ctx.beginPath();
                if (shape.type === "pen" || shape.type === "erase") {
                    ctx.moveTo(shape.startX, shape.startY);
                    for (var i = 1; i < shape.points.length; i++) {
                        ctx.lineTo(shape.points[i].x, shape.points[i].y);
                    }
                } else if (shape.type === "square") {
                    ctx.rect(shape.startX, shape.startY, shape.endX - shape.startX, shape.endY - shape.startY);
                } else if (shape.type === "circle") {
                    var radius = Math.sqrt(Math.pow(shape.endX - shape.startX, 2) + Math.pow(shape.endY - shape.startY, 2));
                    ctx.arc(shape.startX, shape.startY, radius, 0, 2 * Math.PI);
                } else if (shape.type === "line") {
                    ctx.moveTo(shape.startX, shape.startY);
                    ctx.lineTo(shape.endX, shape.endY);
                } else if (shape.type === "text") {
                    ctx.font = "20px sans-serif";
                    ctx.fillStyle = shape.color;
                    ctx.fillText(shape.text, shape.x, shape.y);
                }
                ctx.stroke();
            });
        }

        if (currentShape) {
            ctx.lineWidth = currentShape.type === "erase" ? 20 : 4;
            ctx.strokeStyle = currentShape.type === "erase" ? "white" : currentShape.color;
            ctx.beginPath();
            if (currentShape.type === "pen" || currentShape.type === "erase") {
                ctx.moveTo(currentShape.startX, currentShape.startY);
                for (var i = 1; i < currentShape.points.length; i++) {
                    ctx.lineTo(currentShape.points[i].x, currentShape.points[i].y);
                }
            } else if (currentShape.type === "square") {
                ctx.rect(currentShape.startX, currentShape.startY, currentShape.endX - currentShape.startX, currentShape.endY - currentShape.startY);
            }
            ctx.stroke();
        }
    }

    TextInput {
        id: textInput
        visible: false
        x: 0
        y: 0
        width: 100
        height: 30
        font.pixelSize: 20
        color: currentColor
        onAccepted: {
            if (text.length > 0 && shapes !== undefined) {
                shapes.push(JSON.parse(JSON.stringify({ type: "text", text: text, x: x, y: y, color: currentColor })));
                shapesUpdated(shapes);
            }
            textInput.visible = false;
            textInput.text = "";
            canvas.requestPaint();
        }
        Keys.onEscapePressed: {
            textInput.visible = false;
            textInput.text = "";
            canvas.requestPaint();
        }
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            if (currentTool === "pen" || currentTool === "erase") {
                currentShape = { type: currentTool, startX: mouseX, startY: mouseY, points: [{x: mouseX, y: mouseY}], color: currentColor };
            } else if (currentTool === "square" || currentTool === "circle" || currentTool === "line") {
                currentShape = { type: currentTool, startX: mouseX, startY: mouseY, endX: mouseX, endY: mouseY, color: currentColor };
            } else if (currentTool === "text") {
                textInput.x = mouseX;
                textInput.y = mouseY;
                textInput.visible = true;
                textInput.forceActiveFocus();
            }
        }
        onPositionChanged: {
            if (currentShape) {
                if (currentShape.type === "pen" || currentShape.type === "erase") {
                    currentShape.points.push({x: mouseX, y: mouseY});
                } else if (currentShape.type === "square" || currentShape.type === "circle" || currentShape.type === "line") {
                    currentShape.endX = mouseX;
                    currentShape.endY = mouseY;
                }
                canvas.requestPaint();
            }
        }
        onReleased: {
            if (currentShape && currentTool !== "text" && shapes !== undefined) {
                shapes.push(JSON.parse(JSON.stringify(currentShape)));
                shapesUpdated(shapes);
                currentShape = null;
                canvas.requestPaint();
            }
        }
    }
}
