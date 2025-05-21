import 'models.dart';

enum SegmentType {
  text,
  image,
}

class SegmentItem extends ModelItem {
  final String measure;
  final int order;
  final SegmentType type;

  const SegmentItem({
    required super.id,
    required this.measure,
    required this.order,
    required this.type,
  });
}
