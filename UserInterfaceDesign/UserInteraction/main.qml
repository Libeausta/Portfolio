import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3

Window {
    id: win
    minimumWidth: 180
    minimumHeight: 320
    width: 360
    height: 640
    visible: true
    title: qsTr("UserInteraction")
    color: "#f2f2f2"
    ColumnLayout {
            anchors.fill: parent
            RowLayout {
                Rectangle {
                    id:rect_header
                    color: "#a6a6a6";
                    Layout.fillWidth: true
                    implicitHeight: win.height/10
                    Text{
                        id:txt_head
                        text:"Header"
                        font.pixelSize: parent.height/4
                        anchors.centerIn:rect_header
                    }
                }
            }
            ColumnLayout {
                Rectangle {
                    id: rect_content
                    color: "#f2f2f2"
                    border.color: "#8c8c8c"
                    border.width: 1
                    Layout.margins: 10
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Text{
                        id:txt_cont
                        text:"Content"
                        font.pixelSize: txt_head.font.pixelSize
                        anchors.centerIn:rect_content
                    }
                }
            }
            RowLayout{
                Rectangle {
                    id: rect_bot
                    color: "#bfbfbf";
                    Layout.fillWidth: true
                    implicitHeight: win.height/10

                    GridLayout{
                        rows: 1
                        columns: 3
                        Rectangle{
                            id: but1
                            border.color: "#8c8c8c"
                            border.width: 1
                            color: "#a6a6a6"
                            implicitWidth: rect_bot.width/3
                            implicitHeight: rect_bot.height
                            MouseArea{
                                id:click_but1
                                anchors.fill: parent
                                onClicked: {
                                    txt_head.text = "Header 1"
                                    txt_cont.text = "It's darkseagreen"
                                    but1.color = "#a6a6a6"
                                    txt_but1.color = "black"
                                    but2.color = "#bcbcbc"
                                    txt_but2.color = "#8c8c8c"
                                    but3.color = "#bcbcbc"
                                    txt_but3.color = "#8c8c8c"
                                    rect_content.color = "#99bb93"
                                }
                            }
                            Text{
                                id:txt_but1
                                text:"1"
                                font.pixelSize: parent.height/4
                                anchors.centerIn:but1
                            }

                        }
                        Rectangle{
                            id:but2
                            border.color: "#8c8c8c"
                            border.width: 1
                            color: "#a6a6a6"
                            implicitWidth: rect_bot.width/3
                            implicitHeight: rect_bot.height

                            MouseArea{
                                id:click_but2
                                anchors.fill: parent
                                onClicked: {
                                    txt_head.text = "Header 2"
                                    txt_cont.text = "It's navajowhite"
                                    but1.color = "#bcbcbc"
                                    txt_but1.color = "#8c8c8c"
                                    but2.color = "#a6a6a6"
                                    txt_but2.color = "black"
                                    but3.color = "#bcbcbc"
                                    txt_but3.color = "#8c8c8c"
                                    rect_content.color = "#fadfb3"
                                }
                            }
                            Text{
                                id:txt_but2
                                text:"2"
                                font.pixelSize: parent.height/4
                                anchors.centerIn:but2
                            }

                        }
                        Rectangle{
                            id:but3
                            border.color: "#8c8c8c"
                            border.width: 1
                            color: "#a6a6a6"
                            implicitWidth: rect_bot.width/3
                            implicitHeight: rect_bot.height

                            MouseArea{
                                id:click_but3
                                anchors.fill: parent
                                onClicked: {
                                    txt_head.text = "Header 3"
                                    txt_cont.text = "It's lightpink"
                                    but1.color = "#bcbcbc"
                                    txt_but1.color = "#8c8c8c"
                                    but2.color = "#bcbcbc"
                                    txt_but2.color = "#8c8c8c"
                                    rect_content.color = "#f4b9c1"
                                    but3.color = "#a6a6a6"
                                    txt_but3.color = "black"
                                }
                            }
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
    }
}
