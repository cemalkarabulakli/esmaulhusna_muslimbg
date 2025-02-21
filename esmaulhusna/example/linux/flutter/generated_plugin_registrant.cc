//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <esmaulhusna/esmaulhusna_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) esmaulhusna_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "EsmaulhusnaPlugin");
  esmaulhusna_plugin_register_with_registrar(esmaulhusna_registrar);
}
