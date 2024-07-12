#pragma once

#include <QIcon>
#include <QObject>
#include <QQmlEngine>
#include <QQuickPaintedItem>

class IconImage : public QQuickPaintedItem
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(const QIcon &icon READ icon WRITE setIcon)
public:
    explicit IconImage(QQuickItem *parent = nullptr);

    const QIcon &icon();
    void setIcon(QIcon icon);
    void paint(QPainter *painter) override;

signals:

private:
    QIcon m_icon;
};
