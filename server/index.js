const express = require("express");
var http = require("http");
const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
const mongoose = require("mongoose");

var io = require("socket.io")(server);

// middleware
app.use(express.json());

//connect to our MongoDB
const DB = "mongodb+srv://kashishadwani17:m8gPaXBD7neRY2VN@clusterk.di19i.mongodb.net/?retryWrites=true&w=majority&appName=ClusterK"

mongoose.connect(DB).then(() => {
console.log('Connection Successfull');
}).catch((e)=>{
console.log(e);
})

server.listen(port, "0.0.0.0",()=>{
console.log('Server started ,running on port '+ port);
})