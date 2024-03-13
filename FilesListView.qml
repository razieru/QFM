import QtQuick
import Qt.labs.folderlistmodel
import QtQuick.Controls

ListView {
	id: lVr
	//keyNavigationEnabled: true
    headerPositioning: ListView.OverlayHeader
    header: ItemDelegate {
        z: 2
        width: lVl.width
        text: rightModel.folder.toString().replace("file://","")
    }

    model: FolderListModel {
        id: rightModel
        showDotAndDotDot: true
        showDirsFirst: true
    }
    delegate: ItemDelegate {
        required property string fileName
        required property int index
        width: lVr.width
        text: rightModel.isFolder(index) ? `[${fileName}]` : fileName
		highlighted: lVr.focus && ListView.isCurrentItem
		onClicked: {
			print("clicked")
			ListView.view.currentIndex = index
		}

        onDoubleClicked: {
            if ( rightModel.isFolder(index) ) {
                if (fileName == "..")
                    rightModel.folder = rightModel.parentFolder
                else
                    rightModel.folder += "/" + fileName
            }
        }
    }
}
