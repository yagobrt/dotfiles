// From https://github.com/8bitmcu/NerdFont-Cheat-Sheet

// 1. Open: https://www.nerdfonts.com/cheat-sheet
// 2. Search for ' '. Scroll to the bottom
// 3. Execute the following code in browser console. It will download nerdfont.txt

var txt = "";
document.querySelectorAll(".column").forEach(e => {
  var code = e.querySelector(".codepoint").innerText,
    name = e.querySelector(".class-name").innerText,
    uni = String.fromCodePoint(parseInt(code, 16));
  txt += uni + " " + name.replaceAll("-", ": ") + "\n";
})
var a = document.createElement('a'); document.body.appendChild(a);
var txturl = window.URL.createObjectURL(new Blob([txt], { type: "text/txt" })); a.href = txturl; a.download = "nerdfont.txt", a.click();

