import QtQuick
import Qt.labs.folderlistmodel
import QtQuick.Controls

Window {
	width: 1200
	height: 480
	visible: true
	title: qsTr("QFM")
	color: palette.base
	property FolderListModel activeModel: activeListView.model
	property ListView activeListView: lVl.focus ? lVl : lVr
	Shortcut {
		sequence: "Enter"
		onActivated: {
			print("Enter")
			if (activeModel.isFolder(activeListView.currentIndex)) {
				activeModel.folder += "/" + activeModel.get(activeListView.currentIndex,"fileName")
			}
		}
	}

	Shortcut {
		sequence: "Tab"
		onActivated: {
			if (lVl.focus)
				lVr.forceActiveFocus()
			else
				lVl.forceActiveFocus()
		}
	}




	FilesListView {
		id: lVl
		height: parent.height
		anchors.left: parent.left
		anchors.right: splitter.left
		focus: true
	}
	Rectangle {
		id: splitter
		x: parent.width / 2 - width / 2
		height: parent.height
		width: 1
		color: palette.mid
	}
	FilesListView {
		id: lVr
		height: parent.height
		anchors.left: splitter.right
		anchors.right: parent.right
	}

}
