import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.2
Page{
    id:root
    property alias backgroundColor:back_fon.color
    property alias buttonText:button_nav.text
    property alias buttonText2:button_nav2.text
    signal buttonClicked();
    signal buttonClicked2();
    signal buttonClicked3();
    background: Rectangle{
        id:back_fon
    }
    Button {
        id:button_nav
        width:100
        height:40
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: defMargin
        onClicked: {
            root.buttonClicked()
        }
    }
    Button {
        id:button_nav2
        width:100
        height:40
        anchors.bottom: button_nav.top
        anchors.right: parent.right
        anchors.margins: defMargin
        onClicked: {
            root.buttonClicked2()
        }
    }

}
