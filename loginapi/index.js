const express = require('express');
const mongoose = require('mongoose');
var bodyParser = require('body-parser');
var jwt = require('jsonwebtoken');

const app = express();
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

//*DATABASE CONNECTION
var db = mongoose.createConnection('mongodb://localhost:27017/login_test', { useNewUrlParser: true, useUnifiedTopology: true });

if (!db) {
    console.log("False");
}
else {
    console.log("True");
}

//*SAMPLE REQUEST
app.get('/retrieve', (req, res) => {
    db.collection("Login").find({}).toArray(
        (err, result) => {
            if (err) throw err;
            res.send(result)
        }
    )
})
//*REGISTER REQUEST
app.post('/register', (req, res) => {
    var obj = req.body;
    db.collection("Login").insertOne({
        "username": obj.user,
        "password": obj.pass
    }, (err) => {
        if (err) throw err;
        var token = jwt.sign({
            username : req.body.username,
            password : req.body.password,
            role : req.body.role
        },"masterkey");
        res.send({token:token,msg:"Registered"})
    })
})

//*LOGIN REQUEST
app.post('/login', function (req, res) {
    var username1 = req.body.user;
    var password1 = req.body.pass;
    db.collection("Login").find({
        username: username1,
        password: password1
    }).toArray(function (err, result) {
        if (err) {
            res.send("Credentials are Wrong");
        }
        else if (result.length == 0) {
            res.send("Enter Credentials");
        }
        else {
            res.send(result[0].username + " " + result[0].password + " have successfully logged in");
        }
    })
});

//*CREATE TEAM
app.post('/teamCreate', (req, res) => {
    var obj = req.body
    db.collection("Team").insertOne(
        {
            "name": obj.name,
            "players": obj.players,
            "tagline": obj.tagline,
            "createdby": obj.createdBy
        },
        function (err) {
            if (err) throw err;
            res.send("Successfully Created Team");
        }
    )
});

//*CREATE PLAYER
app.post('/playerCreate', (req, res) => {
    var obj = req.body
    db.collection("Player").insertOne(
        {
            "name": obj.name,
            "team_id": obj.teamName,
            "skill": obj.skills,
            "created_by": obj.createdBy
        },
        function (err) {
            if (err) throw err;
            res.send("Successfully Created Player");
        }
    )
});

//*TEAM DELETE
app.post('/teamDelete', (req, res) => {
    var obj=req.body
    var a = obj.name;
    var b = a;
    db.collection("Team").deleteOne({
        name: obj.name,
    }, function (err) {
        if (err) throw err;
    });
    db.collection("Player").deleteMany({
        team_id: b,
    }, function (err) {
        if (err) throw err;
    });
    res.send("Deleted")
})

//*PLAYER DELETE
app.post('/playerDelete', (req, res) => {
    var obj = req.body
    db.collection("Player").deleteOne({
        name: obj.name,
    }, function (err) {
        if (err) throw err;
        res.send("Deleted");
    })
});

//*TEAM VIEW
app.get('/teamList', (req, res) => {
    db.collection("Team").find({
    }).toArray(function (err, result) {
        if (err) throw err;
        res.send({data:result,value:result.length})
        console.log(result.length);
    })
});

//*PLAYER VIEW
app.get('/playerList', (req, res) => {
    db.collection("Player").find({
    }).toArray(function (err, result) {
        if (err) throw err;
        res.send({data:result,value:result.length})
        console.log(result.length);
    })
});

//*PORT
app.listen(3000)