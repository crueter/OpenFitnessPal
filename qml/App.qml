import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

import OpenFitnessPalContent

Window {
    id: window

    // the height may change depending on the platform
    property int initialHeight: Constants.height

    width: Constants.width
    height: Constants.height

    function yuh() {
        console.log(Qt.inputMethod.keyboardRectangle.height)
        height = initialHeight - Qt.inputMethod.keyboardRectangle.height / 2
    }

    Component.onCompleted: {
        Qt.inputMethod.keyboardRectangleChanged.connect(yuh)
        initialHeight = height
    }

    visible: true

    function newDate(date) {
        exercisesPage.currentDate = date
        foodPage.currentDate = date

        reloadData()
    }

    function reloadMealNames() {
        foodPage.reloadMealNames()
    }

    function reloadData() {
        exercisesPage.reloadData()
        foodPage.reloadData()
    }

    function reloadCache() {
        settings.reloadCache()
    }

    Dialog {
        id: search
        width: window.width
        height: window.height

        property alias food: food

        FoodSearch {
            id: food
            width: parent.width
            height: parent.height

            back.onClicked: search.reject()
        }
    }

    Dialog {
        id: foodEdit
        width: window.width
        height: window.height

        property alias edit: edit

        FoodServingEdit {
            id: edit
            width: parent.width
            height: parent.height

            back.onClicked: foodEdit.reject()

            submit.onClicked: {
                foodEdit.accept()

                ready([foodServing])
            }
        }
    }

    Dialog {
        id: recipeDialog
        width: window.width
        height: window.height

        property alias recipeEdit: recipeEdit

        RecipeEdit {
            id: recipeEdit
            width: parent.width
            height: parent.height

            back.onClicked: recipeDialog.reject()

            submit.onClicked: {
                recipeDialog.accept()
                recipe.name = recipeName.text

                ready(recipe)
            }
        }
    }

    Dialog {
        id: recipeAdd
        width: window.width
        height: window.height

        property alias add: add

        RecipeAdd {
            id: add
            width: parent.width
            height: parent.height

            back.onClicked: recipeAdd.reject()

            submit.onClicked: {
                recipeAdd.accept()

                ready(checkBox.checked ? recipe.asServings(
                                             servings.value
                                             / 100.0) : [recipe.asFood(
                                                             servings.value / 100.0)])
            }
        }
    }

    FolderDialog {
        id: dirSelect
        currentFolder: "/home"
    }

    MessageDialog {
        id: dataConfirm
        text: "The directory you selected appears to contain data already."
        informativeText: "Do you still want to transfer over data from the old directory? Select no if the target directory is from a cloud sync."
        buttons: MessageDialog.Yes | MessageDialog.No | MessageDialog.Cancel
    }

    SwipeView {
        id: swipeView
        objectName: "swipeView"
        anchors.bottom: tabBar.bottom
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.top: dateSelect.bottom
        anchors.left: parent.left
        currentIndex: tabBar.currentIndex

        SettingsPageRoot {
            id: settingsPage

            onMealNamesChanged: reloadMealNames()

            onReloadData: window.reloadData()
            onReloadCache: window.reloadCache()
        }

        ExerciseRootPage {
            id: exercisesPage
            clip: true

            Component.onCompleted: {
                currentDate = new Date()
                reloadData()
            }
        }

        FoodPage {
            id: foodPage
            clip: true
            Component.onCompleted: {
                currentDate = new Date()
                reloadData()
            }
        }

        RecipesPage {}

        GoalsPage {
            onChangeNutrition: foodPage.reloadData()
        }
    }

    TabBar {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        layer.enabled: false
        transformOrigin: Item.Center

        id: tabBar
        y: parent.height - height
        position: TabBar.Footer
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Settings")
        }
        TabButton {
            text: qsTr("Exercise")
        }
        TabButton {
            text: qsTr("Food")
        }
        TabButton {
            text: qsTr("Recipes")
        }
        TabButton {
            text: qsTr("Goals")
        }
    }

    DateSelect {
        id: dateSelect
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter

        onDateChanged: date => newDate(date)
    }
}
