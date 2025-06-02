import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';

// Labels
const String RESOURCE_LIST_TITLE = "Recursos";
const String HINT_RESOURCE_LIST = "Buscar recursos";

const String OPTION_EDIT_RESOURCE_LABEL = "Editar recurso";
const String OPTION_ATTACH_RESOURCE_LABEL = "Adjuntar recurso";
const String OPTION_DETACH_RESOURCE_LABEL = "Desvincular recurso";

// Functions
navigateToResourceItemViewScreen(
  BuildContext context,
  int resource_id, {
  int? post_id,
}) {
  if (post_id != null) {
  } else {
    Navigator.of(context)
        .pushNamed(buildIdRouteById(ROUTER_RESOURCE_VIEW_ROUTE, resource_id));
  }
}

// Builder options
ActionItemModel getActionEditResource(
  BuildContext context,
  ResourceItem resource,
) {
  return ActionItemModel(
    label: OPTION_EDIT_RESOURCE_LABEL,
    icon: Icons.edit,
    onTap: () {
      navigateToResourceItemViewScreen(
        context,
        int.parse(resource.id!),
      );
    },
  );
}

ActionItemModel getActionEditPostResource(
  BuildContext context,
  ResourceItem resource,
  int post_id,
) {
  return ActionItemModel(
    label: OPTION_EDIT_RESOURCE_LABEL,
    icon: Icons.edit,
    onTap: () {
      navigateToResourceItemViewScreen(
        context,
        int.parse(resource.id!),
        post_id: post_id,
      );
    },
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
  BuildContext context,
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
  BuildContext context,
  ResourceItem resource,
  int post_id,
  Function beforeComplete,
  Function onComplete,
) {
  return [
    getActionDetachResource(resource, post_id, beforeComplete, onComplete),
  ];
}
