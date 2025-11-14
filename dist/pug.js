const fs = require("fs");
const pug = require("pug");
const obj = {};
const index = pug.renderFile("src/index.pug", obj);
fs.writeFileSync("dist/index.html", index);
