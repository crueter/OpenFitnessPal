import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

import QtMultimedia

import OpenFitnessPal

SpinBox {
    id: spin
    required property string label

    /** what property to bind to */
    required property string key

    required property int defaultValue

    font.pixelSize: Math.round(18 * Constants.scalar)

    from: 0
    to: 1E9

    editable: true

    value: goalManager.get(key, defaultValue)
    onValueChanged: {
        goalManager.set(key, value)
    }

    contentItem: TextField {
        text: parent.textFromValue(parent.value, parent.locale)

        font: parent.font
        color: Constants.text

        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        readOnly: !parent.editable

        inputMethodHints: Qt.ImhFormattedNumbersOnly

        onEditingFinished: {
            spin.value = parent.valueFromText(text, parent.locale)
        }

        background: Rectangle {
            color: Constants.bg
        }
    }

    up.indicator: Rectangle {
        x: spin.mirrored ? 0 : parent.width - width
        height: parent.height
        implicitWidth: 40 * Constants.scalar
        implicitHeight: 40 * Constants.scalar
        color: Constants.bg
        border.color: Constants.text

        Text {
            text: "+"
            font.pixelSize: spin.font.pixelSize * 2
            color: Constants.text
            anchors.fill: parent
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    down.indicator: Rectangle {
        x: spin.mirrored ? parent.width - width : 0
        height: parent.height
        implicitWidth: 40 * Constants.scalar
        implicitHeight: 40 * Constants.scalar
        color: Constants.bg
        border.color: Constants.text

        Text {
            text: "-"
            font.pixelSize: spin.font.pixelSize * 2
            color: Constants.text
            anchors.fill: parent
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    background: Rectangle {
        color: Constants.bg
        width: parent.width
        border.color: Constants.text
        border.width: 2
        radius: 5
    }

    Text {
        id: floatingLabel
        text: label
        color: Constants.text

        font.pixelSize: Math.round(15 * Constants.scalar)

        anchors {
            left: spin.left
            bottom: spin.top

            bottomMargin: -2
            leftMargin: 10
        }
    }
}
