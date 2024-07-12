import QtQuick
import QtCore
import Qt.labs.folderlistmodel
import QtQuick.Controls

Window {
	id: root
	width: 1200
	height: 480
	visible: true
	title: qsTr("QFM")
	color: palette.base
	property FolderListModel activeModel: activeListView.model
	property ListView activeListView: lVl.focus ? lVl : lVr
	property bool showHidden: false
	Settings {
		property alias leftFolder: lVl.folder
		property alias rgihtFolder: lVr.folder
	}
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
		sequence: "Backspace"
		onActivated: {
			print("Backspace")
			if (activeModel.parentFolder.toString()) {
				activeModel.folder = activeModel.parentFolder
			}
		}
	}

	Shortcut {
		sequence: "Tab"
		onActivated: {
			print("Tab")
			if (lVl.focus)
				lVr.forceActiveFocus()
			else
				lVl.forceActiveFocus()
		}
	}
	Shortcut {
		sequence: "Ctrl+H"
		onActivated: {
			print("Ctrl+H")
			showHidden = !showHidden
		}
	}

	FilesListView {
		id: lVl
		height: parent.height
		anchors.left: parent.left
		anchors.right: splitter.left
		focus: true
		showHidden: root.showHidden
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
		showHidden: root.showHidden
	}

}
