import QtQuick
import QtQuick.Controls

Item {
    id: root

    property var conversations: []
    property var messages: []
    property string activeConversationName: ""
    property string activeConversationStatus: ""
    property string messageLoadError: ""
    readonly property bool mobileMode: width < 700
    property bool mobileConversationVisible: false

    onActiveConversationNameChanged: {
        if (activeConversationName.length > 0)
            mobileConversationVisible = true
    }

    onMobileModeChanged: {
        if (!mobileMode)
            mobileConversationVisible = false
    }

    SplitView {
        id: desktopView
        anchors.fill: parent
        visible: !root.mobileMode

        handle: Rectangle {
            implicitWidth: 6
            color: "transparent"

            Rectangle {
                anchors.centerIn: parent
                width: 1
                height: parent.height
                color: "#e4e7ec"
            }
        }

        ConversationList {
            SplitView.preferredWidth: 310
            SplitView.minimumWidth: 240
            conversations: root.conversations
        }

        ConversationView {
            SplitView.fillWidth: true
            conversationName: root.activeConversationName
            conversationStatus: root.activeConversationStatus
            messages: root.messages
            messageLoadError: root.messageLoadError
        }
    }

    StackLayout {
        id: mobileView
        anchors.fill: parent
        visible: root.mobileMode
        currentIndex: root.mobileConversationVisible ? 1 : 0

        ConversationList {
            conversations: root.conversations
        }

        ConversationView {
            mobileMode: true
            conversationName: root.activeConversationName
            conversationStatus: root.activeConversationStatus
            messages: root.messages
            messageLoadError: root.messageLoadError
            onBackRequested: root.mobileConversationVisible = false
        }
    }
}
