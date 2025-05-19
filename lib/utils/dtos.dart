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
