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
      width: 800
      height: 600
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
            ColumnLayout
            {
                id: information
                spacing: 6
                width: aboutPanel.width - 40
                height: Math.max(mainWindow.height - sponsorshipButton.height - linksButton.height - qfieldAppDirectoryLabel.height - aboutContainer.spacing * 3 - aboutContainer.anchors.topMargin - aboutContainer.anchors.bottomMargin - 10, qfieldPart.height + opengisPart.height + spacing)

                ColumnLayout {
                          id: qfieldPart
                          Layout.fillWidth: true
                          Layout.fillHeight: true

                          MouseArea {
                            Layout.preferredWidth: 138
                            Layout.preferredHeight: 138
                            Layout.alignment: Qt.AlignHCenter
                            Image {
                              id: qfieldLogo
                              width: parent.width
                              height: parent.height
                              fillMode: Image.PreserveAspectFit
                              source: "qrc:/images/qfield_logo.svg"
                              sourceSize.width: width * screen.devicePixelRatio
                              sourceSize.height: height * screen.devicePixelRatio
                            }
                            onClicked: Qt.openUrlExternally("https://qfield.org/")
                          }

                          Label
                          {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignCenter
                            horizontalAlignment: Text.AlignHCenter
                            font: Theme.strongFont
                            color: Theme.light
                            textFormat: Text.RichText
                            wrapMode: Text.WordWrap

                            text: {
                              let links = '<a href="https://github.com/opengisch/QField/commit/' + gitRev + '">' + gitRev.substr(0, 6) + '</a>';
                              if (appVersion && appVersion !== '1.0.0') {
                                links += ' <a href="https://github.com/opengisch/QField/releases/tag/' + appVersion + '">' + appVersion + '</a>';
                              }
                              // the `qgisVersion` has the format `<int>.<int>.<int>-<any text>`, so we get everything before the first `-`
                              const qgisVersionWithoutName = qgisVersion.split("-", 1)[0];
                              const dependencies = [["QGIS", qgisVersionWithoutName], ["GDAL/OGR", gdalVersion], ["Qt", qVersion]];
                              const dependenciesStr = dependencies.map(pair => pair.join(" ")).join(" | ");
                              return "QField<br>" + appVersionStr + " (" + links + ")<br>" + dependenciesStr;
                            }

                            onLinkActivated: link => Qt.openUrlExternally(link)
                          }
                        }
                ColumnLayout {
                  id: opengisPart
                  Layout.fillWidth: true
                  Layout.fillHeight: true

                  MouseArea {
                    Layout.preferredWidth: 91
                    Layout.preferredHeight: 113
                    Layout.alignment: Qt.AlignHCenter
                    Image {
                      id: opengisLogo
                      width: parent.width
                      height: parent.height
                      fillMode: Image.PreserveAspectFit
                      source: "qrc:/images/opengis-logo.svg"
                      sourceSize.width: width * screen.devicePixelRatio
                      sourceSize.height: height * screen.devicePixelRatio
                    }
                    onClicked: Qt.openUrlExternally("https://opengis.ch")
                  }

                  Label {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignCenter
                    horizontalAlignment: Text.AlignHCenter
                    font: Theme.strongFont
                    color: Theme.light
                    textFormat: Text.RichText
                    text: qsTr("Desarrolado por") + '<br><a href="https://opengis.ch">OPENGIS.ch</a>'
                    onLinkActivated: link => Qt.openUrlExternally(link)
                  }
                }


            }




          }

      } 
  }


}

 
