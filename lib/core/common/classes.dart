class LocationObject {
  final String zone;
  final String toLocation;

  LocationObject({
    required this.toLocation,
    required this.zone,
  });
}

class MenuObject {
  final String menuName;
  final String menuSubText;
  bool customTileExpanded;
  final List<String> expandedMenuList;

  MenuObject({
    required this.menuName,
    required this.menuSubText,
    required this.customTileExpanded,
    required this.expandedMenuList,
  });
}
