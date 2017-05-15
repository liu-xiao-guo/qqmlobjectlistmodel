#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDateTime>
#include <QQmlContext>

#include "defs_nicemodels.h"
#include "qqmlobjectlistmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlObjectListModel<MyItem> * testModel = new QQmlObjectListModel<MyItem> (&app, "foo", "bar");

    int year = QDateTime::currentDateTime ().date ().year ();
    QDate date (year, 1, 1);
    while (date.year () == year) {
        MyItem * item = new MyItem;
        item->set_foo (date.dayOfYear ());
        item->set_bar (date.toString ("yyyy-MM-dd"));
        item->update_test (MyEnum::Type (date.dayOfWeek ()));
        testModel->append (item);
        date = date.addDays (1);
    }

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty ("testModel", testModel);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
