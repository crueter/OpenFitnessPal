#ifndef GOALMANAGER_H
#define GOALMANAGER_H

#include <QObject>
#include <QQmlEngine>

class GoalManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit GoalManager(QObject *parent = nullptr);

    Q_INVOKABLE void set(const QString &key, const QVariant &value) const;
    
    Q_INVOKABLE QVariant get(const QString &key, const QVariant &defaultValue) const;
signals:
};

#endif // GOALMANAGER_H
