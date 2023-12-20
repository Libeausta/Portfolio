import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 360
    height: 640
    visible: true
    title: qsTr("Task for layout")
    Item{
        id: root
        anchors.fill: parent
        Rectangle{
            color:"#f2f2f2"
            anchors.fill: parent
        }

        Rectangle{
            id:rect_header
            color: "#a6a6a6"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right:parent.right
            height:parent.height/10

            Text{
                id:txt_head
                text:"Header"
                font.pixelSize: parent.height/4
                anchors.centerIn:rect_header
            }


        }
        Rectangle{
            id:rect_content
            color:"#f2f2f2"
            border.color: "dark gray"
            border.width: 1
            anchors.top: rect_header.bottom
            anchors.left: parent.left
            anchors.right:parent.right
            anchors.bottom: rect_bot.top
            anchors.margins:10
            Text{
                id:txt_cont
                text:"Content"
                font.pixelSize: txt_head.font.pixelSize
                anchors.centerIn:rect_content
            }
        }

        Rectangle{
            id:rect_bot
            height:parent.height/10
            color:"#d9d9d9"
            anchors.left: parent.left
            anchors.right:parent.right
            anchors.bottom: parent.bottom
            Rectangle{
                id:but1
                color:"#a6a6a6"
                height:parent.height
                width:parent.width/3

                Text{
                    id:txt_but1
                    text:"1"
                    font.pixelSize: parent.height/4
                    anchors.centerIn:but1
                }
            }
            Rectangle{
                id:but2
                color:"#a6a6a6"
                height:parent.height
                width:parent.width/3
                anchors.left:but1.right
                anchors.leftMargin:5
//                anchors.rightMargin:5
                Text{
                    id:txt_but2
                    text:"2"
                    font.pixelSize: parent.height/4
                    anchors.centerIn:but2
                }
            }
            Rectangle{
                id:but3
                color:"#a6a6a6"
                height:parent.height
                width:parent.width/3
                anchors.left: but2.right
                anchors.leftMargin:5
                Text{
                    id:txt_but3
                    text:"3"
                    font.pixelSize: parent.height/4
                    anchors.centerIn:but3
                }
            }
        }


    }
}
