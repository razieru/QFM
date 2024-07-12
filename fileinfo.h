#pragma once

#include <QAbstractFileIconProvider>
#include <QIcon>
#include <QObject>
#include <QQmlEngine>

class FileInfo : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
    explicit FileInfo(QObject *parent = nullptr);
    Q_INVOKABLE QIcon getIcon(const QString &filePath) const;
    Q_INVOKABLE qint64 size(const QString &filePath) const;
    Q_INVOKABLE bool execute(const QString &filePath) const;
    Q_INVOKABLE QStringList drives() const;
    Q_INVOKABLE QVariantMap getStorageInfo(const QString &path) const;

signals:
private:
    QAbstractFileIconProvider m_iconProvider;
};
