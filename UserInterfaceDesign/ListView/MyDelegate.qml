import QtQuick 2.15

Item {
    id:deleg_left
    property string message: "?"
    property string time: "?"
    Rectangle{
        id:rect
        border.color:"darkgrey"
        radius:5
        anchors.fill:parent
        gradient:Gradient{
            GradientStop{position:0;color:"lightgray"}
            GradientStop{position:1;color:"white"}
        }
    }
    Row{
        id:row
        anchors.left:parent.left
        anchors.right: parent.right
        height:parent.height
        anchors.margins:16
        Text{
            text:message
            font.pointSize: 11
            anchors.verticalCenter:row.verticalCenter
        }
        Text{
            text:time
            font.pointSize: 11
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }
    }
}
