@JS()
library;

import 'dart:js_interop';
import 'dart:js_interop_unsafe';

void main() async {
  final vscode = (await importModule('vscode').toDart) as VSCode;

  // this is marked "export" in the JS version generated my Microsoft
  void activate(ExtensionContext context) {
    print('Congratulations, your extension "hello-world-dart" is now active!');

    void helloWorld() {
      vscode.window.showInformationMessage('hello, world');
    }

    var disposable = vscode.commands
        .registerCommand('extension.helloWorld', helloWorld.toJS);

    context.subscriptions.add(disposable);
  }

  void deactivate() {}

  // this is the old way to export; how to use Dart to do the new way??
  final exports = globalContext['exports'] as JSObject;

  exports['activate'] = activate.toJS;
  exports['deactivate'] = deactivate.toJS;
}

extension type VSCode(JSObject _) implements JSObject {
  external Commands get commands;
  external Window get window;
}

extension type Commands(JSObject _) implements JSObject {
  external Disposable registerCommand(String command, JSFunction callback,
      [JSAny? thisArg]);
}

extension type Disposable(JSObject _) implements JSObject {}

extension type Window(JSObject _) implements JSObject {
  external JSAny? showInformationMessage(String message);
}

extension type ExtensionContext(JSObject _) implements JSObject {
  external JSArray get subscriptions;
}
