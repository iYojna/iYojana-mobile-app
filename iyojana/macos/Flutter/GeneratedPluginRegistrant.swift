//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import path_provider_macos
import shared_preferences_macos
import sqflite
import text_to_speech_macos

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
  TextToSpeechMacOsPlugin.register(with: registry.registrar(forPlugin: "TextToSpeechMacOsPlugin"))
}
