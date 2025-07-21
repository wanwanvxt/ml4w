pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell

Singleton {
  property string time: Qt.locale().toString(clock.date, "hh:mm A")
  property string date: Qt.locale().toString(clock.date, "ddd, dd/MM/yyyy")
  property string uptime: "0h, 0m"

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
