import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.13
import de.skycoder42.QtAutoUpdater.Core 3.0
import de.skycoder42.QtAutoUpdater.Quick 3.0

ApplicationWindow {
	visible: true
	width: 360
	height: 600
	title: qsTr("Hello World")

	property alias buttonOnly: btnOnlyBox.checked
	property Updater globalUpdater: QtAutoUpdater.createUpdater("/home/sky/Programming/QtLibraries/QtAutoUpdater/examples/autoupdaterwidgets/SimpleUpdaterGui/example.conf")

	StackView {
		id: stackView
		anchors.fill: parent

		initialItem: Page {
			ColumnLayout {
				anchors.centerIn: parent

				CheckBox {
					id: btnOnlyBox
					text: qsTr("update button only")
					checked: false
					Layout.minimumWidth: implicitWidth * 1.3
				}

				Button {
					id: sBtn
					enabled: !buttonOnly
					text: qsTr("GO!")
					onClicked: askDialog.open()
				}

				UpdateButton {
					updater: globalUpdater
				}
			}
		}
	}

	AskUpdateDialog {
		id: askDialog
		updater: buttonOnly ? null : globalUpdater
	}

	ProgressDialog {
		updater: buttonOnly ? null : globalUpdater
	}

	UpdateResultDialog {
		updater: buttonOnly ? null : globalUpdater
	}

	UpdateInfoComponent {
		updater: buttonOnly ? null : globalUpdater
		useAsComponent: true

		goBackCallback: stackView.pop

		onShowComponent: stackView.push(component, params)
	}

	UpdateInstallerComponent {
		updater: globalUpdater
		useAsComponent: true

		goBackCallback: stackView.pop

		onShowComponent: stackView.push(component, params)
	}
}