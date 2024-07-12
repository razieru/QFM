#include "fileinfo.h"
#include <QDesktopServices>
#include <QDir>
#include <QFileInfo>
#include <QJsonObject>
#include <QStorageInfo>

FileInfo::FileInfo(QObject *parent)
    : QObject{parent}
{}

QIcon FileInfo::getIcon(const QString &filePath) const
{
    const QFileInfo file(filePath);
    return m_iconProvider.icon(file);
}

qint64 FileInfo::size(const QString &filePath) const
{
    const QFileInfo file(filePath);
    return file.size();
}

bool FileInfo::execute(const QString &filePath) const
{
    return QDesktopServices::openUrl(QUrl::fromLocalFile(filePath));
}

QStringList FileInfo::drives() const
{
    QStringList ret;
    foreach (QFileInfo info, QDir::drives()) {
        ret << info.absolutePath();
    }
    return ret;
}

QVariantMap FileInfo::getStorageInfo(const QString &path) const
{
    QStorageInfo storage(path);
    QVariantMap value{{"name", storage.name()},
                      {"bytesTotal", storage.bytesTotal()},
                      {"bytesAvailable", storage.bytesAvailable()}};

    return value;
}
