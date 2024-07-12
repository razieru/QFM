#include "filesystem.h"
#include <QAbstractFileIconProvider>

FileSystem::FileSystem(QObject *parent)
    : QFileSystemModel(parent)
{
    setRootPath("D:/Pet");
    //QObject::connect(this, SIGNAL(rootPathChanged), this, SIGNAL(folderChanged));
}

QString FileSystem::getFolder() const
{
    return this->rootPath();
}

void FileSystem::setFolder(const QString &newFolder)
{
    this->setRootPath(newFolder);
}
