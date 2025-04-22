import QtQuick
import QtQuick.Controls

import org.qfield
import org.qgis
import Theme

import QtQuick.Layouts 1.12

Item {
  id: ventana 

  property var mainWindow: iface.mainWindow()

  Component.onCompleted: {
    iface.addItemToPluginsToolbar(pluginButton)
  }
  
  QfToolButton {
    id: pluginButton
    iconSource: 'icon_window.svg'
    iconColor: Theme.mainColor
    bgcolor: Theme.darkGray
    round: true
    
    onClicked: {
       ventanaDialog.open()
    }
  }

  Dialog
  {
      id: ventanaDialog
      parent: iface.mainWindow().contentItem
      width: 300
      height: 200
      modal: true
      title: "Ventana de ejemplo"

      z: 10000
      x: (parent.width - width) / 2
      y: (parent.height - height) / 2

      Rectangle 
      {
       color: "black"
       opacity: 0.8
       anchors.fill: parent
      }

    ColumnLayout 
    {
       id: aboutContainer
       spacing: 6
       anchors.fill: parent
       anchors.margins: 20
       anchors.topMargin: 20 + mainWindow.sceneTopMargin
       anchors.bottomMargin: 20 + mainWindow.sceneBottomMargin

         ScrollView 
         {
            Layout.fillWidth: true
            Layout.fillHeight: true
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical: QfScrollBar 
            {
            }
            contentItem: information
            contentWidth: information.width
            contentHeight: information.height
            clip: true

            MouseArea 
            {
              anchors.fill: parent
              onClicked: ventanaDialog.visible = false
            }
            ColumnLayout {
                id: information
                spacing: 6
                width: aboutPanel.width - 40
                height: Math.max(mainWindow.height - sponsorshipButton.height - linksButton.height - qfieldAppDirectoryLabel.height - aboutContainer.spacing * 3 - aboutContainer.anchors.topMargin - aboutContainer.anchors.bottomMargin - 10, qfieldPart.height + opengisPart.height + spacing)
            }




          }

      } 
  }


}

 