import QtQuick 2.0

ListView {
  height: currentItem.height + 100
  width: this.count * currentItem.width
  model: userModel
  delegate: UserDelegate {}
  currentIndex: userModel.lastIndex
  orientation: ListView.Horizontal
  flickableDirection: Flickable.AutoFlickIfNeeded

  anchors {
    horizontalCenter: parent.horizontalCenter
    verticalCenter: parent.verticalCenter
  }

  focus: true
  clip: true

  Keys.onReturnPressed: {
    page.state = "login";
    loginFrame.name = currentItem.name
    loginFrame.realName = currentItem.realName
    loginFrame.icon = currentItem.icon
    focus = false

    if (config.autoFocusPassword == "true")
      loginFrame.focusPassword();
    else
      loginFrame.focus = true;
  }

  Image {
    id: selector
    width: 32
    height: 32
    source: "assets/selector.png"
    x: listView.currentItem.x + (listView.currentItem.width / 2) - 16
    y: listView.currentItem.y + listView.currentItem.height

    Behavior on x {
      NumberAnimation { duration: 350; easing.type: Easing.InOutQuad}
    }
  }

}
