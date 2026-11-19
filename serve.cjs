const http = require("http");
const fs = require("fs");
const path = require("path");
const root = path.dirname(__filename);
http.createServer((req, res) => {
  const p = path.join(root, decodeURIComponent(req.url.split("?")[0]) === path.join(root, "\\") || req.url.split("?")[0] === "/" ? "index.html" : decodeURIComponent(req.url.split("?")[0].replace(/^\//, "")));
  fs.readFile(p, (err, data) => {
    if (err) { res.writeHead(404); res.end("not found"); return; }
    res.writeHead(200, { "Content-Type": "text/html; charset=utf-8" });
    res.end(data);
  });
}).listen(8741, () => console.log("serving on http://localhost:8741"));
