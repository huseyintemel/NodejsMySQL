const express = require("express");
const app = express();
var mysql=require('mysql');

app.use(express.json());

var baglanti=mysql.createConnection({
    host:"localhost",
    user:"root",
    password:"",
    database:"nodejs"    
});

baglanti.connect((err) =>{
    if(err) throw err;
    console.log('Mysql Connected...');
});

app.get("/",function(req,res){
    res.send("Index sayfası");
});

app.get('/api/products',(req, res) => {
    let sql = "SELECT * FROM product";
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

app.get('/api/products/:id',(req, res) => {
    let sql = "SELECT * FROM product WHERE product_id="+req.params.id;
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

app.post('/api/products',(req, res) => {
    let data = {product_name: req.body.product_name, product_price: req.body.product_price};
    let sql = "INSERT INTO product SET ?";
    let query = baglanti.query(sql, data,(err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

app.put('/api/products/:id',(req, res) => {
    let sql = "UPDATE product SET product_name='"+req.body.product_name+"', product_price='"+req.body.product_price+"' WHERE product_id="+req.params.id;
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});
   
app.delete('/api/products/:id',(req, res) => {
    let sql = "DELETE FROM product WHERE product_id="+req.params.id+"";
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

const port=process.env.PORT || 8080;
app.listen(port);
console.log(`Example app listening at http://localhost:${port}`);
