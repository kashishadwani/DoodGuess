const express = require('express');
var http = require("http");
const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
const mongoose = require("mongoose");

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

io.on('connection', [socket]=>{
console.log('connected');
//create game
socket.on('create-game',async({nickname, name, occupancy, maxRounds}) => {
try{
    console.log("Create-game data received:", { nickname, name, occupancy, maxRounds });
    const existingRoom = await Room.findOne({name});
    if (!nickname || !name || !occupancy || !maxRounds) {
            socket.emit('notCorrectGame', 'Missing required parameters');
            return;
    }
    if(existingRoom){
    socket.emit('notCorrectGame', 'Room with that name already exists!');
    return;
    }
    const room = new Room({
    word: getWord(),
    name,
    occupancy,
    maxRounds,
    players: [{
    socketID: socket.id, nickname, isPartyLeader: true
    }]
    });

    room.players.push(player);
    try{
    await room.save();
    console.log("Room saved successfully:", room);
    }catch(err){
    console.error("Error saving room:", err);
    }
    socket.join(room.name);
    io.to(room.name).emit('updateRoom', room);
} catch(err){
console.log(err);
}
})
//join Game callback
socket.on['join-game',async({nickname, name})=>{
try{
let room = await Room.findOne({name});
if(!room){
socket.emit('notCorrectGame', 'Please enter a valid room name');
return;
}
if(room.isJoin){
let player = {
socketID: socket.id,
nickname,
}
room.players.push(player);
socket.join(name);

if(room.players.length === room.occupancy){
room.isJoin = false;
}
room.turn = room.players[room.turnIndex];
room = await room.save();
io.to(name).emit('updateRoom', room);
}else{
socket.emit('notCorrectGame','The game is in progress, please try later!');
}
}catch(err){
console.log(err);
}
}]
})

server.listen(port, "0.0.0.0",()=>{
console.log('Server started ,running on port '+ port);
})