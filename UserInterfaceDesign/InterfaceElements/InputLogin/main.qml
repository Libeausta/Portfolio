import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Window {
    id: root
    width: 360
    height: 640
    visible: true
    title: qsTr("Login page")
    color: "#82b3aa"
    Column {
        id:column
        anchors.centerIn: parent
        spacing: 20
        TextField{
            id: usernameField
            placeholderText: "Username"
            font.pixelSize: 16
            width: 205
            leftPadding: 5
        }
        TextField {
            id: passwordField
            placeholderText: "Password"
            font.pixelSize: 16
            width: 205
            leftPadding: 5
            echoMode: TextInput.Password
        }

        RowLayout{
            Button {
                id: btnLogIn
                implicitWidth: 100
                text: "Log In"
                font.pointSize: 11
                background: Rectangle {
                    color:"slategrey"
                }
            }
            Button {
                id: btnClear
                implicitWidth: 100
                text: "Clear"
                font.pointSize: 11
                background: Rectangle {
                    color:"slategrey"
                }
                onClicked: {
                    usernameField.clear();
                    passwordField.clear();
                }
            }

        }

    }
}
