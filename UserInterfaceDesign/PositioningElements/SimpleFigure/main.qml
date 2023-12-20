import QtQuick 2.15
import QtQuick.Window 2.15
Window {
        id:win
        width: 480;
        height: 640;
        visible: true;
        title: qsTr("Penguin")
    Rectangle{
        id:rect_main
        width:300
        height:350
        border.color:"black"
        border.width: 50
        anchors.centerIn: parent
    }
    My_comp{
        comWidth: 50
        comHeight: 50
        comColor: "orange"
        anchors.top: rect_main.bottom
        anchors.right: rect_main.right
        anchors.rightMargin: 100

    }
    My_comp{
        comWidth: 50
        comHeight: 50
        comColor: "orange"
        anchors.top: rect_main.bottom
        anchors.left: rect_main.left
        anchors.leftMargin: 50

    }
    My_comp{
        comWidth: 50
        comHeight: 50
        comColor: "black"
        anchors.right:rect_main.right
        anchors.verticalCenter: rect_main.verticalCenter
    }
    My_comp{
        comWidth: 50
        comHeight: 50
        comColor: "black"
        anchors.right:rect_main.left
        anchors.verticalCenter: rect_main.verticalCenter
        anchors.rightMargin: 50
    }
    My_comp{
        comWidth: 50
        comHeight: 50
        comColor: "black"
        anchors.top:rect_main.top
        anchors.right: rect_main.horizontalCenter
        anchors.topMargin: 100
        anchors.rightMargin: -25
    }
    My_comp{
        comWidth: 50
        comHeight: 50
        comColor: "black"
        anchors.top:rect_main.top
        anchors.right: rect_main.horizontalCenter
        anchors.topMargin: 100
        anchors.rightMargin: 75
    }
    My_comp{
        comWidth: 50
        comHeight: 50
        comColor: "orange"
        anchors.top:rect_main.top
        anchors.right: rect_main.horizontalCenter
        anchors.topMargin: 150
        anchors.rightMargin: 25
    }
}

