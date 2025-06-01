vim.dap.adapters.flutter = {
  type = 'executable',
  command = 'flutter', -- if you're using fvm, you'll need to provide the full path to flutter (flutter.bat for windows users), or you could prepend the fvm command
  args = { 'debug_adapter' },
  -- windows users will need to set 'detached' to false
  options = {
    detached = false,
  }
}

vim.dap.configurations.dart = {
  {
    type = "flutter",
    request = "launch",
    name = "Launch flutter",
    dartSdkPath = "/home/miron/development/flutter/bin/cache/dart-sdk/bin/dart", -- ensure this is correct
    flutterSdkPath = "home/miron/development/flutter",                           -- ensure this is correct
    program = "${workspaceFolder}/lib/main.dart",                                -- ensure this is correct
    cwd = "${workspaceFolder}",
  }
}

vim.lsp.enable('dartls')
