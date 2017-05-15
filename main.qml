import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Rectangle {
        id: window;
        width: 600;
        height: 400;

        anchors.fill: parent

        Flickable {
            id: flicker;
            width: parent.width
            height: parent.height
            contentWidth: width;
            contentHeight: layout.childrenRect.height;
            flickableDirection: Flickable.VerticalFlick;

            Column {
                id: layout;
                width: parent.width
                anchors {
                    top: parent.top;
                    left: parent.left;
                    right: parent.right;
                }

               TextInput {
                    anchors {
                        left: parent.left;
                        right: parent.right;
                    }
                }

                Repeater {
                    model: testModel;
                    delegate: Text {
                        text: "<b>%1.</b> %2 (%3) -> %4 = %5".arg (model.foo).arg (model.bar).arg (model.test).arg (model.type).arg (model.qtObject);
                    }
                }
            }
        }
    }

    Timer {
        id: timer;
        repeat: true;
        running: true;
        interval: 1000;
        triggeredOnStart: true;
        onTriggered: {
            if (listOperations.length) {
                listOperations.shift () ();
            }
        }

        property var listOperations : [
            function () {
                console.log ("model count=", testModel.count);
            },
            function () {
                var uid = Qt.formatDate (new Date (), "yyyy-MM-dd");
                var obj = testModel.get (uid);
                console.log ("uid=", uid, "obj=", obj, "val=", obj.bar);
            },
            function () {
                console.log ("model remove idx 3=", (testModel.remove (3) || "DONE"));
            },
            function () {
                console.log ("model move idx 100 to position 1=", (testModel.move (100, 1) || "DONE"));
            },

//            function () {
//                console.log ("'foobar' at 2 :", "foobar".at (2));
//            },

//            function () {
//                var arr = ["fo", "ob", "ar"];
//                 console.log ("arr before=", JSON.stringify (arr));
//                console.log ("arr first=", arr.first ());
//                console.log ("arr last=", arr.last ());
//                arr.removeAt (1);
//                console.log ("arr after remove at 1 =", JSON.stringify (arr));
//            },
//            function () {
//                console.log ("remove all 'o' in 'foobar'=", "foobar".remove ('o'));
//            },
        ];
    }
}
