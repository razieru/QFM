#pragma once

#include <QAbstractItemModel>
#include <QFileSystemModel>
#include <QQmlEngine>

class FileSystem : public QFileSystemModel
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString folder READ getFolder WRITE setFolder NOTIFY folderChanged FINAL)

public:
    explicit FileSystem(QObject *parent = nullptr);

    QString getFolder() const;
    void setFolder(const QString &newFolder);

signals:
    void folderChanged(const QString &newFolder);
};
