import QtQuick
import QtQuick.Controls

import org.qfield
import org.qgis
import Theme

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
    } 
}