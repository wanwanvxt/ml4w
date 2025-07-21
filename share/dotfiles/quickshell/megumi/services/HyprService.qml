pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

Singleton {
  id: root

  property var windows: []
  property var monitors: []
  property var layers: ({})
  property var workspaces: []
  property var activeWorkspace: ({})

  function updateWindows() {
    getClients.running = true;
  }
  function updateMonitors() {
    getMonitors.running = true;
  }
  function updateLayers() {
    getLayers.running = true;
  }
  function updateWorkspaces() {
    getWorkspaces.running = true;
  }
  function updateActiveWorkspace() {
    getActiveWorkspace.running = true;
  }
  function updateAll() {
    updateWindows();
    updateMonitors();
    updateLayers();
    updateWorkspaces();
    updateActiveWorkspace();
  }

  function biggestWindowByWorkspace(wsId) {
    const wndList = windows.filter(w => w.workspace.id == wsId);
    return wndList.reduce((maxWnd, wnd) => {
      const maxArea = (maxWnd?.size[0] ?? 0) * (maxWnd?.size[1] ?? 0);
      const winArea = (wnd?.size[0] ?? 0) * (wnd?.size[1] ?? 0);
      return winArea > maxArea ? wnd : maxWnd;
    }, null);
  }

  Component.onCompleted: {
    updateAll();
  }

  Connections {
    target: Hyprland
    function onRawEvent(event) {
      updateAll();
    }
  }

  Process {
    id: getClients

    command: ["bash", "-c", "hyprctl clients -j | jq -c"]
    stdout: SplitParser {
      onRead: data => {
        root.windows = JSON.parse(data);
      }
    }
  }

  Process {
    id: getMonitors

    command: ["bash", "-c", "hyprctl monitors -j | jq -c"]
    stdout: SplitParser {
      onRead: data => {
        root.monitors = JSON.parse(data);
      }
    }
  }

  Process {
    id: getLayers

    command: ["bash", "-c", "hyprctl layers -j | jq -c"]
    stdout: SplitParser {
      onRead: data => {
        root.layers = JSON.parse(data);
      }
    }
  }

  Process {
    id: getWorkspaces

    command: ["bash", "-c", "hyprctl workspaces -j | jq -c"]
    stdout: SplitParser {
      onRead: data => {
        root.workspaces = JSON.parse(data);
      }
    }
  }

  Process {
    id: getActiveWorkspace

    command: ["bash", "-c", "hyprctl activeworkspace -j | jq -c"]
    stdout: SplitParser {
      onRead: data => {
        root.activeWorkspace = JSON.parse(data);
      }
    }
  }
}
