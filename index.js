const express= require('express');
const mysql=require('mysql');
const session = require('express-session');
const path = require('path');

var app=express();
var bodyParser=require('body-parser');
var con= mysql.createConnection({
	host:'localhost',
	user:'root',
	password:'n0m3l0',
	database:'universal'
});

con.connect();

app.set('view engine', 'jade');
app.use( bodyParser.json() )
app.use(session({
	secret: 'n0m3l0',
	resave: true,
	saveUninitialized: true
}));
app.use(bodyParser.urlencoded({ 
	extended:true
}))

app.use(express.static('public')); 
app.get('/', (req,res)=>{
    getParques(function (err,data){
        nomP = data.map(obj => obj.nom_par);
        res.render('index', {nomP});
    });
}); 
app.use(express.static('public')); 
app.get('/0', (req,res)=>{
    getParques(function (err,data){
        getAtracciones('1', function (err,data1){
            getActividades('1', function (err,data2){
                getHoteles('1', function (err,data3){
                    nomP = data.map(obj => obj.nom_par);
                    nomA = data1.map(obj => obj.nom_atr);
                    desA = data1.map(obj => obj.des_atr);
                    nomAc = data2.map(obj => obj.nom_act);
                    desAc = data2.map(obj => obj.des_act);
                    nomH = data3.map(obj => obj.nom_hot);
                    desH = data3.map(obj => obj.des_hot);
                    res.render('0', {nomP, nomA, nomAc, nomH, desA, desAc, desH});
                })
            })
        })
    })
}); 
app.use(express.static('public')); 
app.get('/1', (req,res)=>{
    getParques(function (err,data){
        getAtracciones('2', function (err,data1){
            getActividades('2', function (err,data2){
                getHoteles('2', function (err,data3){
                    nomP = data.map(obj => obj.nom_par);
                    nomA = data1.map(obj => obj.nom_atr);
                    desA = data1.map(obj => obj.des_atr);
                    nomAc = data2.map(obj => obj.nom_act);
                    desAc = data2.map(obj => obj.des_act);
                    nomH = data3.map(obj => obj.nom_hot);
                    desH = data3.map(obj => obj.des_hot);
                    res.render('1', {nomP, nomA, nomAc, nomH, desA, desAc, desH});
                })
            })
        })
    })
}); 
app.use(express.static('public')); 
app.get('/2', (req,res)=>{
    getParques(function (err,data){
        getAtracciones('3', function (err,data1){
            getActividades('3', function (err,data2){
                getHoteles('3', function (err,data3){
                    nomP = data.map(obj => obj.nom_par);
                    nomA = data1.map(obj => obj.nom_atr);
                    desA = data1.map(obj => obj.des_atr);
                    nomAc = data2.map(obj => obj.nom_act);
                    desAc = data2.map(obj => obj.des_act);
                    nomH = data3.map(obj => obj.nom_hot);
                    desH = data3.map(obj => obj.des_hot);
                    res.render('2', {nomP, nomA, nomAc, nomH, desA, desAc, desH});
                })
            })
        })
    })
}); 
app.use(express.static('public')); 
app.get('/3', (req,res)=>{
    getParques(function (err,data){
            getActividades('1', function (err,data2){
                getHoteles('1', function (err,data3){
                    nomP = data.map(obj => obj.nom_par);
                    nomAc = data2.map(obj => obj.nom_act);
                    desAc = data2.map(obj => obj.des_act);
                    nomH = data3.map(obj => obj.nom_hot);
                    desH = data3.map(obj => obj.des_hot);
                    res.render('3', {nomP, nomAc, nomH, desAc, desH});
                })
            })
    })
}); 
app.use(express.static('public')); 
app.get('/venta', (req,res)=>{
    getParques(function (err,data1){
        getEntradas(function (err,data){
            nomP=data1.map(obj => obj.nom_par);
            id = data.map(obj => obj.id_ent);
            preE = data.map(obj => obj.pre_ent);
            tipoP = data.map(obj => obj.tp_ent);
            desTE = data.map(obj => obj.des_ten);
            nom = data.map(obj => obj.nom_par);
            res.render('venta', {preE, tipoP, desTE, nom, id, nomP});
        })
    })
}); 
app.post('/venta',(req,res) => {
	let can=req.body.cantidadE
	let ent=req.body.tipoE
    console.log(can, ent);
	con.query('INSERT INTO ventaentradas(`can_ven`,`dat_ven`,`id_ent`) values('+can+', now(),'+ent+')',(err,respuesta,fields)=> {
		if(err)return console.log(err)
            getParques(function (err,data){
                nomP = data.map(obj => obj.nom_par);
                res.render('index', {nomP});
            });
	});
});
                            
//Callbacks DB
function getParques(callback) {
    con.query('SELECT nom_par,des_par FROM parques', function(err, rows) {
		if(err) return callback(err);
		callback(null, rows);
    });
}
function getHoteles(idParque, callback) {
    con.query('SELECT nom_hot, des_hot FROM hoteles WHERE id_par=?', [idParque], function(err, rows) {
		if(err) return callback(err);
		callback(null, rows);
    });
}
function getAtracciones(idParque, callback) {
    con.query('SELECT nom_atr, des_atr FROM atracciones WHERE id_par=?',[idParque], function(err, rows) {
		if(err) return callback(err);
		callback(null, rows);
    });
}
function getActividades(idParque, callback) {
    con.query('SELECT nom_act, des_act FROM actividades WHERE id_par=?',[idParque], function(err, rows) {
		if(err) return callback(err);
		callback(null, rows);
    });
}
function getEntradas(callback) {
    con.query('SELECT e.id_ent, e.pre_ent, e.tp_ent, t.des_ten, p.nom_par FROM tipoEntrada t INNER JOIN entradas e ON e.id_ten=t.id_ten INNER JOIN parques p ON p.id_par=e.id_par ORDER BY id_ent', function(err, rows) {
		if(err) return callback(err);
		callback(null, rows);
    });
}

//port
app.listen(5555,()=>{
	console.log('Servidor escuchando en el puerto 5555')
})