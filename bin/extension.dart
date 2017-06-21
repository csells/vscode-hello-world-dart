@JS()
library hello_world_dart;

import 'dart:js' as js; // needed for allowInterop()
import 'package:js/js.dart'; // needed for @JS() and @anonymous
import 'package:node_interop/node_interop.dart'; // require(), exports and Pub transformer

void main() {
  VSCode vscode = require('vscode'); // strong typing FTW

  void activate(ExtensionContext context) {
    print('Congratulations, your extension "hello-world-dart" is now active!');

    void sayHello() {
      vscode.window.showInformationMessage('Hello world');
    }

    var disposable = vscode.commands
        .registerCommand('extension.sayHello', js.allowInterop(sayHello));

    context.subscriptions.add(disposable);
  }

  exports.setProperty('activate', js.allowInterop(activate));
  exports.setProperty('deactivate', js.allowInterop(() {}));
}

@JS()
@anonymous
abstract class VSCode {
  external Commands get commands;
  external Window get window;
}

@JS()
@anonymous
abstract class Commands {
  external Disposable registerCommand(String command, Function callback,
      [dynamic thisArg]);
}

@JS()
@anonymous
abstract class Disposable {}

@JS()
@anonymous
abstract class Window {
  external dynamic showInformationMessage(String message);
}

@anonymous
@JS()
abstract class ExtensionContext {
  external js.JsArray get subscriptions;
}
