const express = require('express');
var http = require("http");
const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
const mongoose = require("mongoose");
mongoose.set('debug', true);
const Room = require('./models/Room');

const getWord = require('./api/getWord');
var io = require("socket.io")(server);

// middleware
app.use(express.json());

//connect to our MongoDB
const DB = "mongodb+srv://kashishadwani17:m8gPaXBD7neRY2VN@clusterk.di19i.mongodb.net/ScribbleDatabase?retryWrites=true&w=majority&appName=ClusterK"

mongoose.connect(DB)
.then(() => {
console.log("Connected to MongoDB");
}).catch((e)=>{
console.log("MongoDB connection error:",e);
})

io.on('connection', (socket)=>{
console.log('connected');
socket.on('create-game',async({nickname, name, occupancy, maxRounds})=>{
try{
    console.log("Create-game data received:", { nickname, name, occupancy, maxRounds });
    const existingRoom = await Room.findOne({name});
    if(existingRoom){
    socket.emit('notCorrectGame', 'Room with that name already exists!');
    return;
    }
    let room = new Room();
    const word = getWord();
    room.word = word;
    room.name = name;
    room.occupancy = occupancy;
    room.maxRounds = maxRounds;

    let player = {
        socketID: socket.id,
        nickname,
        isPartyLeader: true,
    }
    room.players.push(player);
    try{
    room = await room.save();
    console.log("Room saved successfully:", room);
    }catch(err){
    console.error("Error saving room:", err);
    }
    socket.join(room.name);
    io.to(name).emit('updateRoom', room);
} catch(err){
console.log(err);
}
})
})

server.listen(port, "0.0.0.0",()=>{
console.log('Server started ,running on port '+ port);
})