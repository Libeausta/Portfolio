import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.2
ApplicationWindow {
 width: 360
 height: 640
 visible: true
 title: qsTr("StackView_test")
 property int defMargin:10
 StackView{
     id:stack_view
     anchors.fill: parent
     initialItem: page1
     }
     header:ToolBar{
         id:page_header
         height:50
         RowLayout{
             ToolButton{
                id:back_btn
                onClicked: {
                    stack_view.pop(page1)
                }
                 Text{
                     text: "<-"
                     font.pixelSize: 24
                     visible:stack_view.depth > 1
                     anchors.horizontalCenter: parent.horizontalCenter
                 }
             }
         }
     }
     My_Page {
        id:page1
        backgroundColor: "#ff006e"

        buttonText: "To_Purple"
        onButtonClicked: {
           stack_view.push(page2)
        }
        buttonText2: "To_Yellow"
        onButtonClicked2: {
           stack_view.push(page3)
        }

     }
     My_Page {
         id:page2
         visible: false
         backgroundColor: "#8338ec"
         buttonText: "To_Pink"
         onButtonClicked: {
            stack_view.pop(page1)
         }
         buttonText2: "To_Yellow"
         onButtonClicked2: {
            stack_view.pop(page3)
         }
     }
     My_Page {
         id:page3
         visible: false
         backgroundColor: "#ffbe0b"
         buttonText: "To_Pink"
         onButtonClicked: {
            stack_view.pop(page1)
         }
         buttonText2: "To_Purple"
         onButtonClicked2: {
            stack_view.push(page2)
         }
     }
}
