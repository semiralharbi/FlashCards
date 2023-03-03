class ExpansionPanelItem {
  ExpansionPanelItem({
    this.isExpanded = false,
    this.paramList,
    this.param,
    required this.header,
  });

  final String header;
  final List<String>? paramList;
  final String? param;
  bool isExpanded;
}
