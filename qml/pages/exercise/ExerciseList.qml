import QtQuick
import QtQuick.Controls

import OpenFitnessPal

Item {
    required property var model

    ListView {
        id: listView

        clip: true

        anchors {
            top: parent.top
            bottom: button.top
            left: parent.left
            right: parent.right

            topMargin: 5 * Constants.scalar
        }

        spacing: 20 * Constants.scalar

        boundsBehavior: Flickable.StopAtBounds

        model: parent.model

        delegate: Exercise {
            width: listView.width
        }
    }

    Button {
        id: button
        font.pixelSize: 25 * Constants.scalar

        anchors {
            left: parent.left
            right: parent.right

            bottom: parent.bottom

            margins: 8 * Constants.scalar
        }

        text: "Add Exercise"
        onClicked: model.add("Exercise")

        background: Rectangle {
            color: button.pressed ? Constants.accentPressed : Constants.accent
            radius: 5 * Constants.scalar
        }
    }
}