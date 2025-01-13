import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import OpenFitnessPal

BaseSettingsTab {
    id: exercisePage

    title: "Exercises"

    function add(exercises) {
        em.add(exercises)
    }

    Component.onCompleted: em.load()

    ExerciseModel {
        id: em
    }

    ExerciseList {
        model: em

        anchors {
            top: nav.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right

            topMargin: 5 * Constants.scalar
        }
    }
}
