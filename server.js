var express = require('express');
var fs = require('fs');
var app = express();

app.get('/', function (req, res) {
	var targetPage = 'public/index.html';
	fs.readFile(targetPage, function (err, data) {
		res.writeHead(200, { 'Content-Type' : 'text/html' });
		res.end(data, function (err) {
			console.log(err);
		});
	});
});

var server = app.listen(3000, function () {
	console.log('Listening on http://localhost:%d', server.address().port);
});
