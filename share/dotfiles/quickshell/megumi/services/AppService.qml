pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell

Singleton {
  id: root

  readonly property list<DesktopEntry> apps: DesktopEntries.applications.values.slice().sort((a, b) => a.name.localeCompare(b.name))

  function iconExists(icon) {
    return icon && (icon.length > 0) && (Quickshell.iconPath(icon, true).length > 0);
  }

  function guessIcon(cls) {
    if (!cls || cls.length == 0)
      return "image-missing";

    if (iconExists(cls))
      return cls;

    let str = cls;

    str = cls.split(".").slice(-1)[0].toLowerCase();
    if (iconExists(str))
      return str;

    str = cls.toLowerCase().replace(/\s+/g, "-");
    if (iconExists(str))
      return str;

    return cls;
  }
}
