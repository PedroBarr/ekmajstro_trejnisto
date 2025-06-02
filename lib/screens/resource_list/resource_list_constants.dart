import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

// Labels
const String RESOURCE_LIST_TITLE = "Recursos";
const String HINT_RESOURCE_LIST = "Buscar recursos";

// Builder options
ActionItemModel getActionEditResource(ResourceItem resource) {
  return ActionItemModel(
    label: "Editar recurso",
    icon: Icons.edit,
    onTap: () {
      print("Edit resource: ${resource.name}");
    },
  );
}

ActionItemModel getActionAttachResource(
  ResourceItem resource,
  int post_id,
  Function onComplete,
) {
  return ActionItemModel(
    label: "Adjuntar recurso",
    icon: Icons.attach_file,
    onTap: () {
      print("Attach resource: ${resource.name} to post ID: $post_id");
      onComplete();
    },
  );
}

ActionItemModel getActionDetachResource(
  ResourceItem resource,
  int post_id,
  Function onComplete,
) {
  return ActionItemModel(
    label: "Desvincular recurso",
    icon: Icons.remove_circle,
    onTap: () {
      print("Detach resource: ${resource.name} from post ID: $post_id");
      onComplete();
    },
  );
}

List<ActionItemModel> getActionsForUnselectedResource(
  ResourceItem resource,
  int post_id,
  Function onComplete,
) {
  return [
    getActionEditResource(resource),
    getActionAttachResource(resource, post_id, onComplete),
  ];
}

List<ActionItemModel> getActionsForSelectedResource(
  ResourceItem resource,
  int post_id,
  Function onComplete,
) {
  return [
    getActionEditResource(resource),
    getActionDetachResource(resource, post_id, onComplete),
  ];
}
