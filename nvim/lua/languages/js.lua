vim.snippet.add("at", "/** @type {${1:Type}} */\n$0", {ft = "javascript"})
vim.snippet.add("ai", "/** @implements {${1:Interface}} */\n$0", {ft = "javascript"})
vim.snippet.add("ad", "/** @typedef {${0:Typename}} */\n$0", {ft = "javascript"})
vim.snippet.add("lg", 'console.log("$1")', {ft = "javascript"})

vim.dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {"/home/miron/repos/js-debug/src/dapDebugServer.js", "${port}"},
  }
}

vim.dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    outputCapture = "std",
  },
}
