## extensions keybind

adds a keybind (ctrl + shift + x) to open the extensions settings, like in vscode
```js
document.addEventListener("keydown", function (event) {
  if ((event.ctrlKey || event.metaKey) && event.shiftKey && event.key === "X") {
    Vencord.Webpack.findByProps("saveAccountChanges", "open").open(
      "EquicordSettings",
      null,
    );
  }
});
```
<sup>*if using vencord instead of equicord, change it to `VencordSettings`</sup>

## settings keybind

adds a keybind (ctrl + ,) to open settings, like in vscode
```js
document.addEventListener("keydown", function (event) {
  if ((event.ctrlKey || event.metaKey) && event.key === ",") {
    Vencord.Webpack.findByProps("saveAccountChanges", "open").open(
      "My Account",
      null,
    );
  }
});
```
