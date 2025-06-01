import 'package:ekmajstro_trejnisto/models/models.dart';

List<PostItem> dtoPostItemList(List<dynamic> list) {
  List<PostItem> posts = [];

  for (final postResponse in list) {
    PostItem post = PostItem.fromJson(postResponse);
    posts.add(post);
  }

  return posts;
}

List<SectionItem> dtoSectionItemList(List<dynamic> list) {
  List<SectionItem> sections = [];

  for (final sectionResponse in list) {
    SectionItem section = SectionItem.fromJson(sectionResponse);
    sections.add(section);
  }

  return sections;
}

List<ResourceItem> dtoResourceItemList(List<dynamic> list) {
  List<ResourceItem> resources = [];

  for (final resourceResponse in list) {
    ResourceItem resource = ResourceItem.fromJson(resourceResponse);
    resources.add(resource);
  }

  return resources;
}

List<TagItem> dtoTagItemList(List<dynamic> list) {
  List<TagItem> tags = [];

  for (final tagResponse in list) {
    TagItem tag = TagItem.fromJson(tagResponse);
    tags.add(tag);
  }

  return tags;
}

List<SegmentItem> dtoSegmentItemList(List<dynamic> list) {
  List<SegmentItem> segments = [];

  for (final segmentResponse in list) {
    SegmentItem segment = SegmentItem.fromJson(segmentResponse);
    segments.add(segment);
  }

  return segments;
}

List<Tag> dtoTagList(List<dynamic> list) {
  List<Tag> tags = [];

  for (final tagResponse in list) {
    Tag tag = Tag.fromJson(tagResponse);
    tags.add(tag);
  }

  return tags;
}

List<ResourceTypeItem> dtoResourceTypeItemList(List<dynamic> list) {
  List<ResourceTypeItem> resourceTypes = [];

  for (final resourceTypeResponse in list) {
    ResourceTypeItem resourceType =
        ResourceTypeItem.fromJson(resourceTypeResponse);
    resourceTypes.add(resourceType);
  }

  return resourceTypes;
}
