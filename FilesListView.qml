import QtQuick
import Qt.labs.folderlistmodel
import QtQuick.Controls
import qfm

ListView {
	id: lVr
	//keyNavigationEnabled: true
	headerPositioning: ListView.OverlayHeader
	property alias showHidden: rightModel.showHidden
	property alias folder: rightModel.folder



	boundsMovement: Flickable.StopAtBounds
	header: Rectangle {
		height: headerCol.height
		width: lVl.width
		z:99
		color: palette.base
		Column {
			id: headerCol
			Row {
				spacing: 8
				Repeater {
					model: FileInfo.drives()
					delegate: Label {
						text: modelData
						opacity: driveMA.containsMouse ? 0.8 : 1
						MouseArea {
							id: driveMA
							anchors.fill: parent
							hoverEnabled: true
							onClicked: rightModel.folder = "file:///" + modelData
						}
					}
				}
				Label {
					text: {

						let store = FileInfo.getStorageInfo(rightModel.folder.toString().replace("file:///",""))
						return store.name + " " + (1.0-store.bytesAvailable/store.bytesTotal).toFixed(2)
					}
				}
			}
			Row {
				id: currentFolderRow
				spacing: 8
				readonly property var pathArray: rightModel.folder.toString().replace("file:///","").split("/")
				Repeater {
					model: currentFolderRow.pathArray
					delegate: Label {
						property string locFolder: currentFolderRow.pathArray.slice(0, index + 1 ).join("/")
						text: modelData
						opacity: mA.containsMouse ? 0.8 : 1

						MouseArea {
							id: mA
							anchors.fill: parent
							hoverEnabled: true
							onClicked: rightModel.folder = "file:///" + parent.locFolder + "/"
						}
						ToolTip{
							visible: mA.containsMouse
							text: locFolder
						}
					}
				}
			}
		}
	}

	model: FolderListModel {
		id: rightModel
		showDotAndDotDot: false
		showDirsFirst: true
		sortCaseSensitive: false
	}
	delegate: ItemDelegate {
		id:qqq
		required property string fileName
		required property int index
		width: lVr.width
		highlighted: lVr.focus && ListView.isCurrentItem
		Row {
			spacing: 8
			IconImage {
				width: qqq.height
				height: width
				icon: {
					let sep = "/"
					if (rightModel.folder.toString().endsWith("/"))
						sep = ""
					FileInfo.getIcon(rightModel.folder.toString().replace("file:///","") + sep + fileName)
				}
				//anchors.verticalCenter: parent.verticalCenter
			}
			Label {
				text: fileName
			}
			// Label {
			// 	text: {
			// 		let sep = "/"
			// 		if (rightModel.folder.toString().endsWith("/"))
			// 			sep = ""
			// 		FileInfo.size(rightModel.folder.toString().replace("file:///","") + sep + fileName)
			// 	}
			// }
		}

		onClicked: {
			lVr.forceActiveFocus()
			ListView.view.currentIndex = index
		}

		onDoubleClicked: {
			if ( rightModel.isFolder(index) ) {
				if (fileName == "..")
					rightModel.folder = rightModel.parentFolder
				else {
					let sep = "/"
					if (rightModel.folder.toString().endsWith("/"))
						sep = ""
					rightModel.folder = rightModel.folder + sep + fileName
				}
			} else {
				let sep = "/"
				if (rightModel.folder.toString().endsWith("/"))
					sep = ""
				FileInfo.execute(rightModel.folder + sep + fileName)
			}
		}
	}
}
