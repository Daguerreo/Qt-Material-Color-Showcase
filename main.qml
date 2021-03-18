import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: root
    visible: true
    width: 584
    height: 846

    property var selectedSquare
    property var selectedColor: Material.Red
    property var selectedShade: Material.Shade500
    property var selectedName: "Red"
    property var selectedShadeName: "Shade500"

    onSelectedSquareChanged: {
        selectedSquare.border.width = 2
    }

    property var names: [
        "Red"         ,
        "Pink"        ,
        "Purple"      ,
        "Deep Purple" ,
        "Indigo"      ,
        "Blue"        ,
        "Light Blue"  ,
        "Cyan"        ,
        "Teal"        ,
        "Green"       ,
        "Light Green" ,
        "Lime"        ,
        "Yellow"      ,
        "Amber"       ,
        "Orange"      ,
        "Deep Orange" ,
        "Brown"       ,
        "Grey"        ,
        "Blue Grey"
    ]
    property var colors: [
        Material.Red	    ,
        Material.Pink	    ,
        Material.Purple	    ,
        Material.DeepPurple	,
        Material.Indigo	    ,
        Material.Blue	    ,
        Material.LightBlue	,
        Material.Cyan	    ,
        Material.Teal	    ,
        Material.Green	    ,
        Material.LightGreen	,
        Material.Lime	    ,
        Material.Yellow	    ,
        Material.Amber	    ,
        Material.Orange	    ,
        Material.DeepOrange	,
        Material.Brown	    ,
        Material.Grey	    ,
        Material.BlueGrey
    ]
    property var shades: [
        Material.Shade50,
        Material.Shade100,
        Material.Shade200,
        Material.Shade300,
        Material.Shade400,
        Material.Shade500,
        Material.Shade600,
        Material.Shade700,
        Material.Shade800,
        Material.Shade900,
        Material.ShadeA100,
        Material.ShadeA200,
        Material.ShadeA400,
        Material.ShadeA700
    ]
    property var shadeNames: [
        "Shade50",
        "Shade100",
        "Shade200",
        "Shade300",
        "Shade400",
        "Shade500",
        "Shade600",
        "Shade700",
        "Shade800",
        "Shade900",
        "ShadeA100",
        "ShadeA200",
        "ShadeA400",
        "ShadeA700"
    ]

    property int spacing: 2
    property int squareSize: 32
    property int radius: 4

    Pane {
        id: pane
        anchors.fill: parent
        padding: 2

        ScrollView {
            anchors.fill: parent
            padding: 0
            contentWidth: grid.implicitWidth
            contentHeight: grid.implicitHeight

            ColumnLayout {
                id: grid
                width: pane.width - pane.padding
                height: pane.height - pane.padding

                RowLayout {
                    spacing: root.spacing
                    clip: true

                    ColumnLayout {
                        anchors.margins: 5
                        spacing: root.spacing
                        clip: true

                        Repeater {
                            model: names
                            Label {
                                Layout.row: index
                                Layout.column: 0
                                Layout.fillHeight: true
                                height: squareSize
                                text: modelData
                                verticalAlignment: "AlignVCenter"
                            }
                        }
                    }

                    Repeater {
                        model: shades

                        ColumnLayout {
                            property int columnIndex: index
                            spacing: root.spacing
                            clip: true

                            Repeater {
                                model: colors
                                Rectangle {
                                    id: square
                                    property var currentColor: modelData
                                    property var currentShade: shades[columnIndex]
                                    property int rowIndex: index

                                    width: root.squareSize
                                    height: root.squareSize
                                    radius: root.radius
                                    color: Material.color(modelData, shades[columnIndex])
                                    border.width: 0
                                    border.color: root.Material.theme === Material.Light ? "black" : "white"
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true

                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            if(selectedSquare) selectedSquare.border.width = 0
                                            selectedSquare = square
                                            selectedColor = square.currentColor
                                            selectedShade = square.currentShade
                                            selectedName = names[rowIndex]
                                            selectedShadeName = shadeNames[columnIndex]
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                ToolSeparator {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    orientation: Qt.Horizontal
                }

                Pane {
                    Layout.fillWidth: true
                    clip: true
                    RowLayout {
                        GridLayout {
                            Layout.fillWidth: false
                            Layout.fillHeight: false
                            columns: 2

                            Label {
                                text: checkTheme.checked ? "Dark" : "Light"
                                Layout.fillWidth: true
                            }
                            CheckBox {
                                id: checkTheme
                                Layout.fillWidth: false
                                onCheckedChanged: {
                                    if(checked) root.Material.theme = Material.Dark
                                    else root.Material.theme = Material.Light
                                }
                            }

                            Label { text: "Color"; Layout.fillWidth: true }
                            Label { text: selectedName; Layout.fillWidth: true }
                            Label { text: "RGB"; Layout.fillWidth: true }
                            TextField {
                                text: Material.color(selectedColor, selectedShade)
                                Layout.fillWidth: false
                                readOnly: true
                                selectByMouse: true
                            }
                            Label { text: "Shade"; Layout.fillWidth: true }
                            Label { text: selectedShadeName; Layout.fillWidth: true }
                        }

                        ToolSeparator {}

                        GridLayout {
                            id: spectrum
                            columns: 7
                            columnSpacing: 0
                            rowSpacing: 0

                            property int size: 100
                            Layout.fillHeight: false
                            Layout.fillWidth: true

                            Rectangle {
                                width: spectrum.size
                                height: spectrum.size
                                color: Material.color(selectedColor, selectedShade)
                                GridLayout.rowSpan: 2
                                GridLayout.columnSpan: 2
                                GridLayout.fillWidth: true

                                TextInput {
                                    anchors.bottom: parent.bottom
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    readOnly: true
                                    text: Material.color(selectedColor, selectedShade)
                                    selectByMouse: true
                                    font: root.font
                                    color: "white"
                                }
                            }

                            Repeater {
                                model: 5

                                Rectangle {
                                    width: spectrum.size/2
                                    height: spectrum.size/2
                                    color: Qt.lighter(Material.color(selectedColor, selectedShade), 1.1+(index/10) )

                                    TextInput {
                                        anchors.bottom: parent.bottom
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        readOnly: true
                                        text: parent.color
                                        selectByMouse: true
                                        font.family: root.font.family
                                        font.pointSize: 6
                                        color: "white"
                                    }
                                }
                            }

                            Repeater {
                                model: 5

                                Rectangle {
                                    width: spectrum.size/2
                                    height: spectrum.size/2
                                    color: Qt.darker(Material.color(selectedColor, selectedShade), 1.1+2*(index/10) )

                                    TextInput {
                                        anchors.bottom: parent.bottom
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        readOnly: true
                                        text: parent.color
                                        selectByMouse: true
                                        font.family: root.font.family
                                        font.pointSize: 6
                                        color: "white"
                                    }
                                }
                            }
                        }

                    }
                }

            }


        }

    }
}


