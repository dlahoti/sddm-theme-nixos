import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
  id: loginFrame

  width: page.width
  height: page.height
  anchors.horizontalCenter: page.horizontalCenter
  anchors.verticalCenter: page.verticalCenter

  property string name
  property string realName
  property string icon
  focus: false

  Behavior on opacity {
    NumberAnimation { duration: 500; easing.type: Easing.InOutQuad }
  }

  //Functions:

  //Logins in with current details
  function login() {
    loginFrame.opacity = 0;
    sddm.login(loginFrame.name, passwordInput.text, sessionSelect.currentIndex);
  }

  //Goes back to user select
  function back() {
    page.state = "";
    listView.focus = true;
  }

  function focusPassword() {
    passwordInput.focus = true;
  }

  KeyNavigation.tab: passwordInput
  Keys.onEscapePressed: back()

  Connections {
    target: sddm
    onLoginSucceeded: {
    }

    onLoginFailed: {
      loginFrame.opacity = 1;
      passwordInput.text = ""
      passwordStatus.opacity = 1;
      passwordTimer.start();
    }
  }

  states: State {
      name: "active"
      when: passwordInput.activeFocus == true || passwordInput.text != ""

      PropertyChanges {
        target: defaultPasswordText
        opacity: 0
      }

      PropertyChanges {
        target: submitPassword
        opacity: 1
      }

      PropertyChanges {
        target: passwordUnderline
        height: 50
      }
  }

  transitions: Transition {
    from: ""
    to: "active"
    reversible: true

    PropertyAnimation {
      properties: "opacity"
      easing.type: Easing.InOutQuad
      duration: 750
    }

    PropertyAnimation {
      properties: "height"
      easing.type: Easing.InOutQuad
      duration: 750
    }
  }

  Item {
    id: userProfile

    width: 250
    height: 150

    anchors {
      horizontalCenter: parent.horizontalCenter
      verticalCenter: parent.verticalCenter
    }

    Text {
      id: usersName

      color: "#e6ebff"
      font {
        family: "FiraMono"
        pointSize: 20
      }
      text: loginFrame.realName
      anchors.horizontalCenter: parent.horizontalCenter
    }
  }

  Text {
    id: passwordStatus

    text: "Incorrect Password!"
    color: "#e6ebff"
    font {
      pointSize: 10
      family: "FiraMono"
    }

    anchors {
      horizontalCenter: parent.horizontalCenter
      top: passwordBox.bottom
      topMargin: 10
    }

    opacity: 0

    Timer {
      id: passwordTimer
      interval: 3000
      running: false
      repeat: false
      onTriggered: {
        passwordStatus.opacity= 0
      }
    }

    Behavior on opacity {
      NumberAnimation{
        duration: 500
        easing.type: Easing.InOutQuad
      }
    }

  }

  Item {
    id: passwordBox

    width: 300
    height: 50
    anchors {
      horizontalCenter: parent.horizontalCenter
      top: userProfile.bottom
      topMargin: -75
    }

    Text {
      id: defaultPasswordText

      anchors {
        fill: parent
        topMargin: 15
        leftMargin: 15
      }
      text: "Password..."
      color: "#e6ebff"
      font {
        pointSize: 14
        family: "FiraMono"
      }
      opacity: 0.3
    }

    TextInput {
      id: passwordInput

      verticalAlignment: TextInput.AlignVCenter
      anchors {
        fill: parent
        leftMargin: 15
        rightMargin: 50
      }
      font {
        pointSize: 14
        family: "FiraMono"
        letterSpacing: 2
      }
      color: "#e6ebff"
      echoMode:TextInput.Password
      clip: true

      onAccepted: {
        loginFrame.login()
      }

    }

    Image {
      id: submitPassword

      x: 260
      y: 10
      width: 30
      height: 30
      opacity: 0
      source: "assets/rightarrow.png"

      MouseArea {
        anchors.fill: parent
        onClicked: {
          loginFrame.login()
        }
      }
    }

  }

  Rectangle {
    id: passwordUnderline

    width: passwordBox.width
    height: 1
    anchors {
      bottom: passwordBox.bottom
      left: passwordBox.left
    }
    color: "#e6ebff"
    opacity: 0.3
    radius: 4
  }

}
