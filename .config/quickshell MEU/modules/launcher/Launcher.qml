import "root:/"
import "root:/services"
import "root:/modules/common"
import "root:/modules/common/widgets"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland

Scope {
    id: launcherScope
    property bool dontAutoCancelSearch: false
    Variants {
        id: launcherVariants
        model: Quickshell.screens
        PanelWindow {
            id: root
            required property var modelData
            property string searchingText: ""
            readonly property HyprlandMonitor monitor: Hyprland.monitorFor(root.screen)
            property bool monitorIsFocused: (Hyprland.focusedMonitor?.id == monitor.id)
            screen: modelData
            visible: GlobalStates.launcherOpen

            WlrLayershell.namespace: "quickshell:launcher"
            WlrLayershell.layer: WlrLayer.Overlay
            // WlrLayershell.keyboardFocus: GlobalStates.launcherOpen ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None
            color: "transparent"

            mask: Region {
                item: GlobalStates.launcherOpen ? columnLayout : null
            }
            HyprlandWindow.visibleMask: Region {
                item: GlobalStates.launcherOpen ? columnLayout : null
            }


            anchors {
                top: true
                left: true
                right: true
                bottom: true
            }

            HyprlandFocusGrab {
                id: grab
                windows: [ root ]
                property bool canBeActive: root.monitorIsFocused
                active: false
                onCleared: () => {
                    if (!active) GlobalStates.launcherOpen = false
                }
            }

            Connections {
                target: GlobalStates
                function onlauncherOpenChanged() {
                    if (!GlobalStates.launcherOpen) {
                        searchWidget.disableExpandAnimation()
                        launcherScope.dontAutoCancelSearch = false;
                    } else {
                        if (!launcherScope.dontAutoCancelSearch) {
                            searchWidget.cancelSearch()
                        }
                        delayedGrabTimer.start()
                    }
                }
            }

            Timer {
                id: delayedGrabTimer
                interval: ConfigOptions.hacks.arbitraryRaceConditionDelay
                repeat: false
                onTriggered: {
                    if (!grab.canBeActive) return
                    grab.active = GlobalStates.launcherOpen
                }
            }

            implicitWidth: columnLayout.implicitWidth
            implicitHeight: columnLayout.implicitHeight

            function setSearchingText(text) {
                searchWidget.setSearchingText(text);
            }

            ColumnLayout {
                id: columnLayout
                visible: GlobalStates.launcherOpen
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                }

                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Escape) {
                        GlobalStates.launcherOpen = false;
                    } else if (event.key === Qt.Key_Left) {
                        if (!root.searchingText) Hyprland.dispatch("workspace r-1");
                    } else if (event.key === Qt.Key_Right) {
                        if (!root.searchingText) Hyprland.dispatch("workspace r+1");
                    }
                }

                Item {
                    height: 1 // Prevent Wayland protocol error
                    width: 1 // Prevent Wayland protocol error
                }

                SearchWidget {
                    id: searchWidget
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 200
                    onSearchingTextChanged: (text) => {
                        root.searchingText = searchingText
                    }
                }

                // Loader {
                //     id: launcherLoader
                //     active: GlobalStates.launcherOpen
                //     sourceComponent: launcherWidget {
                //         panelWindow: root
                //         visible: (root.searchingText == "")
                //     }
                // }
            }

        }
    }

    IpcHandler {
		target: "launcher"

        function toggle() {
            GlobalStates.launcherOpen = !GlobalStates.launcherOpen
        }
        function close() {
            GlobalStates.launcherOpen = false
        }
        function open() {
            GlobalStates.launcherOpen = true
        }
        function toggleReleaseInterrupt() {
            GlobalStates.superReleaseMightTrigger = false
        }
	}

    GlobalShortcut {
        name: "launcherToggle"
        description: qsTr("Toggles launcher on press")

        onPressed: {
            GlobalStates.launcherOpen = !GlobalStates.launcherOpen   
        }
    }
    GlobalShortcut {
        name: "launcherClose"
        description: qsTr("Closes launcher")

        onPressed: {
            GlobalStates.launcherOpen = false
        }
    }
    GlobalShortcut {
        name: "launcherToggleRelease"
        description: qsTr("Toggles launcher on release")

        onPressed: {
            GlobalStates.superReleaseMightTrigger = true
        }

        onReleased: {
            if (!GlobalStates.superReleaseMightTrigger) {
                GlobalStates.superReleaseMightTrigger = true
                return
            }
            GlobalStates.launcherOpen = !GlobalStates.launcherOpen   
        }
    }
    GlobalShortcut {
        name: "launcherToggleReleaseInterrupt"
        description: qsTr("Interrupts possibility of launcher being toggled on release. ") +
            qsTr("This is necessary because GlobalShortcut.onReleased in quickshell triggers whether or not you press something else while holding the key. ") +
            qsTr("To make sure this works consistently, use binditn = MODKEYS, catchall in an automatically triggered submap that includes everything.")

        onPressed: {
            GlobalStates.superReleaseMightTrigger = false
        }
    }
    GlobalShortcut {
        name: "launcherClipboardToggle"
        description: qsTr("Toggle clipboard query on launcher widget")

        onPressed: {
            if (GlobalStates.launcherOpen && launcherScope.dontAutoCancelSearch) {
                GlobalStates.launcherOpen = false;
                return;
            }
            for (let i = 0; i < launcherVariants.instances.length; i++) {
                let panelWindow = launcherVariants.instances[i];
                if (panelWindow.modelData.name == Hyprland.focusedMonitor.name) {
                    launcherScope.dontAutoCancelSearch = true;
                    panelWindow.setSearchingText(
                        ConfigOptions.search.prefix.clipboard
                    );
                    GlobalStates.launcherOpen = true;
                    return
                }
            }
        }
    }

    GlobalShortcut {
        name: "launcherEmojiToggle"
        description: qsTr("Toggle emoji query on launcher widget")

        onPressed: {
            if (GlobalStates.launcherOpen && launcherScope.dontAutoCancelSearch) {
                GlobalStates.launcherOpen = false;
                return;
            }
            for (let i = 0; i < launcherVariants.instances.length; i++) {
                let panelWindow = launcherVariants.instances[i];
                if (panelWindow.modelData.name == Hyprland.focusedMonitor.name) {
                    launcherScope.dontAutoCancelSearch = true;
                    panelWindow.setSearchingText(
                        ConfigOptions.search.prefix.emojis
                    );
                    GlobalStates.launcherOpen = true;
                    return
                }
            }
        }
    }

}
