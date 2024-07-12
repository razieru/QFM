#include "iconimage.h"

IconImage::IconImage(QQuickItem *parent)
    : QQuickPaintedItem{parent}
{}

const QIcon &IconImage::icon()
{
    return m_icon;
}

void IconImage::setIcon(QIcon icon)
{
    m_icon = icon;
}

void IconImage::paint(QPainter *painter)
{
    m_icon.paint(painter, 0, 0, int(width()), int(height()));
}
