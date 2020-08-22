class ImageOption {
  bool showAngles;
  bool showLines;
  bool showTriangle;
  bool alwaysExpandImage;

  ImageOption({
    this.showAngles = true,
    this.showLines = true,
    this.showTriangle = true,
    this.alwaysExpandImage = false,
  });

  void toggleShowAngles() {
    this.showAngles = !this.showAngles;
  }

  void toggleShowLines() {
    this.showLines = !this.showLines;
  }

  void toggleShowTriangle() {
    this.showTriangle = !this.showTriangle;
  }

  void toggleAlwaysExpand() {
    this.alwaysExpandImage = !this.alwaysExpandImage;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageOption &&
          runtimeType == other.runtimeType &&
          showAngles == other.showAngles &&
          showTriangle == other.showTriangle &&
          alwaysExpandImage == other.alwaysExpandImage;

  @override
  int get hashCode =>
      showAngles.hashCode ^ showTriangle.hashCode ^ alwaysExpandImage.hashCode;

  @override
  String toString() {
    return 'ImageOption{showAngles: $showAngles, showTriangle: $showTriangle, alwaysExpandImage: $alwaysExpandImage}';
  }
}
