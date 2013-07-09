var sys = require('sys'),
    http = require('http'),
    fs = require('fs'),
    kitten;

fs.readFile('kitty.png', function (err, data) {
    "use strict";
    if (err) {
        throw err;
    }
    kitten = data;
});

var http = require('http');
http.createServer(function (req, res) {
    "use strict";

    res.writeHead(200, {
        'Content-Type': 'image/png'
    });
    res.end(kitten);

    var qs, json,
        split_at = req.url.indexOf('?');
    if (split_at !== -1) {
        console.log("\n\n-------");
        console.log(req.headers['user-agent']);

        qs = req.url.substr(split_at + 1);
        json = decodeURIComponent(qs);
        try {
            console.log(JSON.parse(json));
        } catch (e) {
            console.log('error decoding json:', json, e);
        }
    }

}).listen(4444);

console.log('Beacon started at http://127.0.0.1:4444/');
