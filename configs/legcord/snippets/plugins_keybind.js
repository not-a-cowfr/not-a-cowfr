// ctrl + shift + x to open plugins settings, like vscode
document.addEventListener("keydown", function (event) {
  if ((event.ctrlKey || event.metaKey) && event.shiftKey && event.key === "X") {
    Vencord.Webpack.findByProps("saveAccountChanges", "open").open(
      "EquicordSettings",
      null,
    );
  }
});
