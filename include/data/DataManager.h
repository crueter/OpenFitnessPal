#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include "FoodItem.h"

#include <QDir>

typedef std::tuple<FoodItem, ServingSize, double> FoodServing;

class Exercise;

class DataManager
{
public:
    static void init();

    enum DataError {
        Success,
        Failure,
        NoOp
    };

    static DataError removeFood(int meal, QDate date, const FoodItem &item);
    static DataError saveFood(int meal, QDate date, const FoodItem &item, const ServingSize &size, const double units);
    static QList<FoodServing> loadFoods(int meal, QDate date);

    static DataError saveExercises(QList<Exercise *> exercises, QDate date);
    static QList<Exercise *> loadExercises(QWidget *parent, QDate date);

    static DataError saveInfo(QString field, QVariant data);
    static QVariantMap loadInfo();
    static QVariant getInfo(const QString &field);

private:
    static QDir dataDir;
};

#endif // DATAMANAGER_H
