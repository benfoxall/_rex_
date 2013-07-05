var sys = require('sys'),
    http = require('http'),
    fs = require('fs'),
    kitten;
 
fs.readFile('kitty.png', function (err, data) {
    if (err) {
        throw err;
    }
    kitten = data;
});


var http = require('http');
http.createServer(function (req, res) {
  
  
  res.writeHead(200, {'Content-Type': 'image/png'});
  res.end(kitten);
  
  var split_at = req.url.indexOf('?');
  if(split_at != -1){
    console.log("\n\n-------");
    console.log(req.headers['user-agent']);
    
    var qs = req.url.substr(split_at + 1);
    try{
      var json = decodeURI(qs);
      console.log(JSON.parse(json));
    } catch(e){
      console.log('error decoding json:',json, e)
    }
  }
  
  
}).listen(4444);

console.log('Beacon started at http://127.0.0.1:4444/');