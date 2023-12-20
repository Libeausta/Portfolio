import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
Rectangle{
    id:root;
    height:60
    gradient:Gradient{
        GradientStop{position:0;color:"lightgray"}
        GradientStop{position:1;color:"white"}
    }
    signal newMessage(string msg)
    TextField {
        id: edtText
        selectByMouse: true
        anchors.fill:root
        placeholderText: "Write a message..."
        font.pointSize: 10.5
        leftPadding: 10
        verticalAlignment: Text.AlignVCenter
    }
    Button {
        id: btnAddItem
        height:root.height
        width:120
        anchors.right:parent.right
        text: "Send"
        font.pointSize: 10.5
        background: Rectangle {
            color:"lightgray"
        }
        onClicked: {
            newMessage(edtText.text);
            edtText.clear();
        }
    }
}
