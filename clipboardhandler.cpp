#include "clipboardhandler.h"
#include <QGuiApplication>
#include <QClipboard>
#include <QMimeData>
#include <QDebug>
#include <QBuffer>
#include <QByteArray>

QImage ClipboardImageProvider::clipboardImage;

ClipboardHandler::ClipboardHandler(QObject *parent) : QObject(parent)
{
}

void ClipboardHandler::copyImage(const QString &imageDataUrl)
{
    if (imageDataUrl.startsWith("data:image/")) {
        int commaIndex = imageDataUrl.indexOf(',');
        if (commaIndex != -1) {
            QString base64Data = imageDataUrl.mid(commaIndex + 1);
            QByteArray imageData = QByteArray::fromBase64(base64Data.toUtf8());
            QImage image;
            if (image.loadFromData(imageData)) {
                QGuiApplication::clipboard()->setImage(image);
            }
        }
    }
}

void ClipboardHandler::paste()
{
    const QClipboard *clipboard = QGuiApplication::clipboard();
    const QMimeData *mimeData = clipboard->mimeData();

    if (mimeData->hasImage()) {
        m_clipboardImage = qvariant_cast<QImage>(mimeData->imageData());
        ClipboardImageProvider::clipboardImage = m_clipboardImage;
        emit pasteImageReady();
    }
}

ClipboardImageProvider::ClipboardImageProvider() : QQuickImageProvider(QQuickImageProvider::Image)
{
}

QImage ClipboardImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    Q_UNUSED(id);
    Q_UNUSED(requestedSize);

    if (size) {
        *size = clipboardImage.size();
    }
    return clipboardImage;
}
