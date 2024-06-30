class WayPart {
  WayPart? parent;
  int x;
  int y;

  WayPart(this.parent, this.x, this.y);

  String getName() {
    return "($x,$y)";
  }

  @override
  bool operator ==(other) => other is WayPart && getName() == other.getName();
  
  
}
