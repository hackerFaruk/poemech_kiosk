// faruk kudurtan pin kontroller iş başında
// kodun içine python ve bash dayamak kaç para abi,
// elli dokuz doksan san san san san

// dart ayo severiz
import 'dart:io';

void activate() async {
  Process.run('python', ['activate.py']);
}

void deactivate() async {
  Process.run('python', ['deactivate.py']);
}

void pwd() async {
  ProcessResult result = await Process.run('pwd', []);

  // Print the result
  print('Exit code: ${result.exitCode}');
  print('stdout: ${result.stdout}');
  print('stderr: ${result.stderr}');
}


// sudo mode 

//  Process.start('sudo', [command, ...arguments])