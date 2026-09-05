import QtQuick 2.0
import calamares.slideshow 1.0

Presentation
{
    id: presentation

    Slide
    {
        Image
        {
            source: "fennec-wallpaper.png"
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
        }

        Rectangle
        {
            anchors.fill: parent
            color: "#66000000"
        }

        Text
        {
            anchors.centerIn: parent
            text: qsTr("Welcome to Fennec Linux")
            color: "white"
            font.pixelSize: 32
            font.bold: true
        }
    }
}
