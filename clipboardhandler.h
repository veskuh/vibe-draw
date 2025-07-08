#ifndef CLIPBOARDHANDLER_H
#define CLIPBOARDHANDLER_H

#include <QObject>
#include <QImage>
#include <QQuickImageProvider>

class ClipboardHandler : public QObject
{
    Q_OBJECT
public:
    explicit ClipboardHandler(QObject *parent = nullptr);

    Q_INVOKABLE void copyImage(const QString &imageDataUrl);
    Q_INVOKABLE void paste();

signals:
    void pasteImageReady();

private:
    QImage m_clipboardImage;
    friend class ClipboardImageProvider;
};

class ClipboardImageProvider : public QQuickImageProvider
{
public:
    ClipboardImageProvider();
    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;

    static QImage clipboardImage;
};

#endif // CLIPBOARDHANDLER_H
