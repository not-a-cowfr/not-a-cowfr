// ctrl + shift + x to open settings, like vscode
document.addEventListener("keydown", function (event) {
  if ((event.ctrlKey || event.metaKey) && event.key === ",") {
    Vencord.Webpack.findByProps("saveAccountChanges", "open").open(
      "My Account",
      null,
    );
  }
});
