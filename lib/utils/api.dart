import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'app.dart';
import 'dtos.dart';
import 'misc.dart';
import 'router.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/config/config.dart';

const String PUBLICACIONES_ENDPOINT = '/publicaciones';
const String PUBLICACION_ENDPOINT = '/publicacion/$ROUTE_ID_WILDCARD';
const String PUBLICACION_NUEVA_ENDPOINT = '/publicacion';

const String SECCIONES_PUBLICACION_ENDPOINT =
    '/publicacion/$ROUTE_ID_WILDCARD/secciones';
const String SECCION_NUEVA_ENDPOINT = '/seccion';
const String SECCION_ENDPOINT = '/seccion/$ROUTE_ID_WILDCARD';

const String RECURSOS_PUBLICACION_ENDPOINT =
    '/publicacion/$ROUTE_ID_WILDCARD/recursos';
const String RECURSOS_ENDPOINT = '/recursos';

const String ETIQUETAS_PUBLICACION_ENDPOINT =
    '/publicacion/$ROUTE_ID_WILDCARD/etiquetas';
const String ETIQUETAS_ENDPOINT = '/etiquetas';
const String ETIQUETAR_PUBLICACION_ENDPOINT = '/publicacion/etiqueta';
const String DESETIQUETAR_PUBLICACION_ENDPOINT =
    '/publicacion/etiqueta/$ROUTE_ID_WILDCARD';
const String ETIQUETA_NUEVA_ENDPOINT = '/etiqueta';

const String PREVISUALIZACION_PUBLICACION_ENDPOINT =
    '/publicacion/$ROUTE_ID_WILDCARD/previsualizacion';

const String SEGMENTOS_SECCION_ENDPOINT =
    '/seccion/$ROUTE_ID_WILDCARD/segmentos';
const String SEGMENTO_ENDPOINT = '/segmento/$ROUTE_ID_WILDCARD';
const String SEGMENTO_REUBICAR_ENDPOINT =
    '/segmento/$ROUTE_ID_WILDCARD/reubicar';
const String SEGMENTO_NUEVO_ENDPOINT = '/segmento';

Future<List<PostItem>> getPosts({bool? with_preview}) async {
  try {
    final query_params = {
      'con_previsualizacion': (with_preview ?? false).toString(),
    };

    final response = await http.get(
      Uri.parse(BACKEND_API + PUBLICACIONES_ENDPOINT)
          .replace(queryParameters: query_params),
    );

    late List<dynamic> body = getBody(response);
    late List<PostItem> posts = dtoPostItemList(body);
    return posts;
  } catch (e) {
    throw Exception(ERROR_POST_ITEM_LIST);
  }
}

Future<Post> getPost(String id) async {
  try {
    String subPath =
        PUBLICACION_ENDPOINT.replaceAll(ROUTE_ID_WILDCARD, id.toString());

    final response = await http.get(
      Uri.parse(BACKEND_API + subPath),
    );

    late dynamic body = getBody(response);
    late Post post = Post.fromJson(body);
    return post;
  } catch (e) {
    throw Exception(ERROR_POST_ITEM);
  }
}

Future<Post> savePost(Post post) async {
  if (post.id.isNotEmpty) {
    return updatePost(post);
  } else {
    return createPost(post);
  }
}

Future<Post> updatePost(Post post) async {
  try {
    String subPath =
        PUBLICACION_ENDPOINT.replaceAll(ROUTE_ID_WILDCARD, post.id);

    final response = await http.put(
      Uri.parse(BACKEND_API + subPath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post.toMap(true)),
    );

    late dynamic body = getBody(response);
    late Post new_post = Post.fromJson(body);

    return new_post;
  } catch (e) {
    throw Exception(ERROR_POST_ITEM);
  }
}

Future<Post> createPost(Post post) async {
  try {
    String subPath = PUBLICACION_NUEVA_ENDPOINT;

    final response = await http.post(
      Uri.parse(BACKEND_API + subPath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post.toMap(true)),
    );

    late dynamic body = getBody(response);
    late Post new_post = Post.fromJson(body);

    return new_post;
  } catch (e) {
    throw Exception(ERROR_POST_ITEM);
  }
}

Future<List<SectionItem>> getPostSections(Post post) async {
  try {
    String subPath =
        SECCIONES_PUBLICACION_ENDPOINT.replaceAll(ROUTE_ID_WILDCARD, post.id);

    final response = await http.get(
      Uri.parse(BACKEND_API + subPath),
    );

    late List<dynamic> body = getBody(response);
    late List<SectionItem> sections = dtoSectionItemList(body);

    return sections;
  } catch (e) {
    throw Exception(ERROR_SECTION_ITEM_LIST);
  }
}

Future<List<ResourceItem>> getPostResources(Post post) async {
  try {
    String subPath =
        RECURSOS_PUBLICACION_ENDPOINT.replaceAll(ROUTE_ID_WILDCARD, post.id);

    final response = await http.get(
      Uri.parse(BACKEND_API + subPath),
    );

    late List<dynamic> body = getBody(response);
    late List<ResourceItem> resources = dtoResourceItemList(body);

    return resources;
  } catch (e) {
    throw Exception(ERROR_RESOURCE_ITEM_LIST);
  }
}

Future<List<TagItem>> getPostTags(Post post) async {
  try {
    String subPath =
        ETIQUETAS_PUBLICACION_ENDPOINT.replaceAll(ROUTE_ID_WILDCARD, post.id);

    final response = await http.get(
      Uri.parse(BACKEND_API + subPath),
    );

    late List<dynamic> body = getBody(response);
    late List<TagItem> tags = dtoTagItemList(body);

    return tags;
  } catch (e) {
    throw Exception(ERROR_TAG_ITEM_LIST);
  }
}

Future<PreviewItem> getPostPreview(Post post) async {
  try {
    String subPath = PREVISUALIZACION_PUBLICACION_ENDPOINT.replaceAll(
        ROUTE_ID_WILDCARD, post.id);

    final response = await http.get(
      Uri.parse(BACKEND_API + subPath),
    );
    if (response.statusCode == 404) {
      return PreviewItem();
    }

    late dynamic body = getBody(response);
    late PreviewItem preview = PreviewItem.fromJson(body);

    return preview;
  } catch (e) {
    throw Exception(ERROR_PREVIEW_ITEM);
  }
}

Future<Section> getSection(String id) async {
  try {
    final query_params = {
      'con_es_marcada': true.toString(),
    };

    String subPath =
        SECCION_ENDPOINT.replaceAll(ROUTE_ID_WILDCARD, id.toString());

    final response = await http.get(
      Uri.parse(BACKEND_API + subPath).replace(
        queryParameters: query_params,
      ),
    );

    late dynamic body = getBody(response);
    late Section section = Section.fromJson(body);
    return section;
  } catch (e) {
    throw Exception(ERROR_POST_ITEM);
  }
}

Future<List<SegmentItem>> getSectionSegments(Section section) async {
  try {
    String subPath =
        SEGMENTOS_SECCION_ENDPOINT.replaceAll(ROUTE_ID_WILDCARD, section.id);

    final response = await http.get(
      Uri.parse(BACKEND_API + subPath),
    );

    late List<dynamic> body = getBody(response);
    late List<SegmentItem> segments = dtoSegmentItemList(body);

    return segments;
  } catch (e) {
    throw Exception(ERROR_SEGMENT_ITEM_LIST);
  }
}

Future<Section> saveSection(Section section, int? postId) async {
  if (section.id.isNotEmpty) {
    return updateSection(section);
  } else if (postId != null) {
    return createSection(section, postId);
  } else {
    return Future.value(section);
  }
}

Future<Section> createSection(Section section, int postId) async {
  try {
    String subPath = SECCION_NUEVA_ENDPOINT;

    Map<String, dynamic> sectionMap = section.toMap(true, true);
    sectionMap['publicacion'] = postId;

    final response = await http.post(
      Uri.parse(BACKEND_API + subPath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(sectionMap),
    );

    late dynamic body = getBody(response);
    late Section new_section = Section.fromJson(body);

    return new_section;
  } catch (e) {
    throw Exception(ERROR_SECTION_ITEM);
  }
}

Future<Section> updateSection(Section section) async {
  try {
    String subPath = SECCION_ENDPOINT.replaceAll(ROUTE_ID_WILDCARD, section.id);

    final response = await http.put(
      Uri.parse(BACKEND_API + subPath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(section.toMap(false, true)),
    );

    late dynamic body = getBody(response);
    late Section new_section = Section.fromJson(body);

    return new_section;
  } catch (e) {
    throw Exception(ERROR_SECTION_ITEM);
  }
}

Future<Section> markSection(Section section) async {
  try {
    String subPath = SECCION_ENDPOINT.replaceAll(ROUTE_ID_WILDCARD, section.id);

    Map<String, dynamic> sectionMap = {
      'es_marcada': true,
    };

    final response = await http.put(
      Uri.parse(BACKEND_API + subPath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(sectionMap),
    );

    late dynamic body = getBody(response);
    late Section new_section = Section.fromJson(body);

    return new_section;
  } catch (e) {
    throw Exception(ERROR_SECTION_ITEM);
  }
}

Future<Segment> getSegment(String id) async {
  try {
    String subPath =
        SEGMENTO_ENDPOINT.replaceAll(ROUTE_ID_WILDCARD, id.toString());

    final response = await http.get(
      Uri.parse(BACKEND_API + subPath),
    );

    late dynamic body = getBody(response);
    late Segment segment = Segment.fromJson(body);

    return segment;
  } catch (e) {
    throw Exception(ERROR_SEGMENT_ITEM);
  }
}

Future<bool> relocateSegment(SegmentItem segment, String direction) async {
  try {
    String subPath = SEGMENTO_REUBICAR_ENDPOINT.replaceAll(
        ROUTE_ID_WILDCARD, segment.id.toString());

    Map<String, dynamic> cargador = {
      'reubicacion': direction,
    };

    final response = await http.patch(
      Uri.parse(BACKEND_API + subPath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(cargador),
    );

    return response.statusCode == 200;
  } catch (e) {
    throw Exception(ERROR_SEGMENT_ITEM);
  }
}

Future<Segment> saveSegment(Segment segment, int? sectionId) async {
  if (segment.id.isNotEmpty) {
    return updateSegment(segment);
  } else if (sectionId != null) {
    return createSegment(segment, sectionId);
  } else {
    return Future.value(segment);
  }
}

Future<Segment> createSegment(Segment segment, int sectionId) async {
  try {
    String subPath = SEGMENTO_NUEVO_ENDPOINT;

    Map<String, dynamic> segmentMap = segment.toMap(false, true);
    segmentMap['seccion'] = sectionId;

    final response = await http.post(
      Uri.parse(BACKEND_API + subPath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(segmentMap),
    );

    late dynamic body = getBody(response);
    late Segment new_segment = Segment.fromJson(body);

    return new_segment;
  } catch (e) {
    throw Exception(ERROR_SEGMENT_ITEM);
  }
}

Future<Segment> updateSegment(Segment segment) async {
  try {
    String subPath =
        SEGMENTO_ENDPOINT.replaceAll(ROUTE_ID_WILDCARD, segment.id);

    final response = await http.put(
      Uri.parse(BACKEND_API + subPath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(segment.toMap(true, true)),
    );

    late dynamic body = getBody(response);
    late Segment new_segment = Segment.fromJson(body);

    return new_segment;
  } catch (e) {
    throw Exception(ERROR_SEGMENT_ITEM);
  }
}

Future<List<Tag>> getTags() async {
  try {
    final response = await http.get(
      Uri.parse(BACKEND_API + ETIQUETAS_ENDPOINT),
    );

    late dynamic body = getBody(response);
    late List<Tag> tags = dtoTagList(body);

    return tags;
  } catch (e) {
    throw Exception(ERROR_TAG_ITEM_LIST);
  }
}

Future<List<Tag>> getPostTagsList(int post_id) async {
  try {
    String subPath = ETIQUETAS_PUBLICACION_ENDPOINT.replaceAll(
        ROUTE_ID_WILDCARD, post_id.toString());

    final response = await http.get(
      Uri.parse(BACKEND_API + subPath),
    );

    late dynamic body = getBody(response);
    late List<Tag> tags = dtoTagList(body);

    return tags;
  } catch (e) {
    throw Exception(ERROR_TAG_ITEM_LIST);
  }
}

Future<List<Tag>> tagPost(int post_id, int tag_id) async {
  try {
    Map<String, dynamic> tag_map = {
      'publicacion': post_id,
      'etiqueta': tag_id,
    };

    final response = await http.post(
      Uri.parse(BACKEND_API + ETIQUETAR_PUBLICACION_ENDPOINT),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(tag_map),
    );

    late dynamic body = getBody(response);
    late List<Tag> tags = dtoTagList(body);

    return tags;
  } catch (e) {
    throw Exception(ERROR_TAG_ITEM_LIST);
  }
}

Future<List<Tag>> untagPost(int post_id, int tag_id) async {
  try {
    String subPath = DESETIQUETAR_PUBLICACION_ENDPOINT.replaceAll(
        ROUTE_ID_WILDCARD, tag_id.toString());

    Map<String, dynamic> tag_map = {
      'publicacion': post_id,
    };

    final response = await http.delete(
      Uri.parse(BACKEND_API + subPath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(tag_map),
    );

    late dynamic body = getBody(response);
    late List<Tag> tags = dtoTagList(body);

    return tags;
  } catch (e) {
    throw Exception(ERROR_TAG_ITEM_LIST);
  }
}

Future<Tag> createTag(Tag tag) async {
  try {
    final response = await http.post(
      Uri.parse(BACKEND_API + ETIQUETA_NUEVA_ENDPOINT),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(tag.toMap(true)),
    );

    late dynamic body = getBody(response);
    late Tag new_tag = Tag.fromJson(body);

    return new_tag;
  } catch (e) {
    throw Exception(ERROR_TAG_ITEM);
  }
}

Future<List<ResourceItem>> getResources() async {
  try {
    final response = await http.get(
      Uri.parse(BACKEND_API + RECURSOS_ENDPOINT).replace(
        queryParameters: {'con_todo': 'true'},
      ),
    );

    late dynamic body = getBody(response);
    late List<ResourceItem> resources = dtoResourceItemList(body);

    return resources;
  } catch (e) {
    throw Exception(ERROR_RESOURCE_ITEM_LIST);
  }
}
