const http = require('http');

const PORT = process.env.PORT || 3000;

const server = http.createServer((req, res) => {

    if (req.url === '/') {
        res.writeHead(200, {
            'Content-Type': 'text/plain'
        });

        res.end('Hello, world!');
    } else {
        res.writeHead(404, {
            'Content-Type': 'text/plain'
        });

        res.end('Not Found');
    }

});

server.listen(PORT, '127.0.0.1', () => {
    console.log(`Server running on port ${PORT}`);
});
