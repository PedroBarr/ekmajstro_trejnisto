import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';

// Labels
const String RESOURCE_LIST_TITLE = "Recursos";
const String HINT_RESOURCE_LIST = "Buscar recursos";

const String OPTION_EDIT_RESOURCE_LABEL = "Editar recurso";
const String OPTION_ATTACH_RESOURCE_LABEL = "Adjuntar recurso";
const String OPTION_DETACH_RESOURCE_LABEL = "Desvincular recurso";

// Builder options
ActionItemModel getActionEditResource(ResourceItem resource) {
  return ActionItemModel(
    label: OPTION_EDIT_RESOURCE_LABEL,
    icon: Icons.edit,
    onTap: () {},
  );
}

ActionItemModel getActionAttachResource(
  ResourceItem resource,
  int post_id,
  Function beforeComplete,
  Function onComplete,
) {
  return ActionItemModel(
    label: OPTION_ATTACH_RESOURCE_LABEL,
    icon: Icons.attach_file,
    onTap: () {
      beforeComplete();

      attachResourceToPost(post_id, resource).whenComplete(() {
        onComplete();
      });
    },
  );
}

ActionItemModel getActionDetachResource(
  ResourceItem resource,
  int post_id,
  Function beforeComplete,
  Function onComplete,
) {
  return ActionItemModel(
    label: OPTION_DETACH_RESOURCE_LABEL,
    icon: Icons.remove_circle,
    onTap: () {
      beforeComplete();

      detachResourceFromPost(post_id, resource).whenComplete(() {
        onComplete();
      });
    },
  );
}

List<ActionItemModel> getActionsForUnselectedResource(
  ResourceItem resource,
  int post_id,
  Function beforeComplete,
  Function onComplete,
) {
  return [
    getActionAttachResource(resource, post_id, beforeComplete, onComplete),
  ];
}

List<ActionItemModel> getActionsForSelectedResource(
  ResourceItem resource,
  int post_id,
  Function beforeComplete,
  Function onComplete,
) {
  return [
    getActionDetachResource(resource, post_id, beforeComplete, onComplete),
  ];
}
