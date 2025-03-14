#include "include/esmaulhusna_muslimbg/esmaulhusna_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "esmaulhusna_plugin.h"

void EsmaulhusnaPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  esmaulhusna_muslimbg::EsmaulhusnaPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
