const express = require("express");
const app = express();
var mysql=require('mysql');

app.use(express.json());

var baglanti=mysql.createConnection({
    host:"localhost",
    user:"root",
    password:"",
    database:"library"    
});

baglanti.connect((err) =>{
    if(err) throw err;
    console.log('Mysql Connected...');
});

//Index page
app.get("/",function(req,res){
    res.send("Index sayfası");
});

//showing all books
app.get('/kitaplar',(req, res) => {
    let sql = "SELECT * FROM kitaplar";
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

//showing selected book
app.get('/kitaplar/:id',(req, res) => {
    let sql = "SELECT * FROM kitaplar WHERE kitap_id="+req.params.id;
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

//posting a new book
app.post('/kitaplar',(req, res) => {
    let data = {kitapismi: req.body.kitapismi, tur: req.body.tur, yıl : req.body.yıl , fiyat: req.body.fiyat};
    let sql = "INSERT INTO kitaplar SET ?";
    let query = baglanti.query(sql, data,(err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

//updating a book
app.put('/kitaplar/:id',(req, res) => {
    let sql = "UPDATE kitaplar SET kitapismi='"+req.body.kitapismi+"', tur='"+req.body.tur+"', yıl='"+req.body.yıl+"', fiyat='"+req.body.fiyat+"' WHERE kitap_id="+req.params.id;
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

//deleting a book
app.delete('/kitaplar/:id',(req, res) => {
    let sql = "DELETE FROM kitaplar WHERE kitap_id="+req.params.id+"";
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

//showing all authors
app.get('/yazarlar',(req, res) => {
    let sql = "SELECT * FROM yazarlar";
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

//showing selected author
app.get('/yazarlar/:id',(req, res) => {
    let sql = "SELECT * FROM yazarlar WHERE yazar_id="+req.params.id;
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});


//posting a new author
app.post('/yazarlar',(req, res) => {
    let data = {yazarisim: req.body.yazarisim, dogumtarihi: req.body.dogumtarihi, cinsiyet : req.body.cinsiyet};
    let sql = "INSERT INTO yazarlar SET ?";
    let query = baglanti.query(sql, data,(err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

//updating a author
app.put('/yazarlar/:id',(req, res) => {
    let sql = "UPDATE yazarlar SET yazarisim='"+req.body.yazarisim+"', dogumtarihi='"+req.body.dogumtarihi+"', cinsiyet='"+req.body.cinsiyet+"' WHERE yazar_id="+req.params.id;
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

//deleting a author
app.delete('/yazarlar/:id',(req, res) => {
    let sql = "DELETE FROM yazarlar WHERE yazar_id="+req.params.id+"";
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

//showing book name and author name with inner join
app.get('/kitapisimleri',(req, res) => {
    let sql = "SELECT kitaplar.kitapismi,yazarlar.yazarisim FROM kitaplar INNER JOIN yazarlar ON kitaplar.kitap_id = yazarlar.yazar_id";
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

//showing books with page parameter and limit
app.get('/books',(req,res)=>{
    const limit = 4;
    const page = req.query.page;
    const offset = (page - 1) * limit;
    const sql = "SELECT * FROM kitaplar LIMIT "+limit+" OFFSET "+offset;
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        var jsonResult = {
            'kitap_count':results.length,
            'page_number':page,
            'kitaplar':results
        }
        // create response
        var myJsonString = JSON.parse(JSON.stringify(jsonResult));
        res.statusMessage = "Books for page "+page;
        res.statusCode = 200;
        res.json(myJsonString);
        res.end();    
    });

});

//showing book and author with page parameter
app.get('/bookandauthor',(req,res)=>{
    const limit = 4;
    const page = req.query.page;
    const offset = (page - 1) * limit;
    const sql = "SELECT kitaplar.kitapismi,yazarlar.yazarisim FROM kitaplar INNER JOIN yazarlar ON kitaplar.kitap_id = yazarlar.yazar_id LIMIT "+limit+" OFFSET "+offset;
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        var jsonResult = {
            'kitap_count':results.length,
            'page_number':page,
            'kitapveyazar':results
        }

        var myJsonString = JSON.parse(JSON.stringify(jsonResult));
        res.statusCode = 200;
        res.json(myJsonString);
        res.end();    
    });

});

//showing count of books of each category
app.get('/bookcategoryandcount',(req, res) => {
    let sql = "SELECT COUNT(kitaplar.kitap_id) as toplam , kitaplar.tur FROM kitaplar GROUP BY kitaplar.tur";
    //let sql = "SELECT COUNT(kitaplar.kitap_id) as toplam FROM kitaplar UNION SELECT SUM(kitaplar.fiyat) FROM kitaplar" // showing count of books and sum of book prices
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

//showing average price of book categories
app.get('/bookavgprices',(req, res) => {
    let sql = "SELECT kitaplar.tur,AVG(kitaplar.fiyat) as ortalama FROM kitaplar GROUP BY kitaplar.tur";
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

//showing books in descending order if price>40 and tur=Roman 
app.get('/bookorderby',(req, res) => {
    let sql = "SELECT * FROM kitaplar WHERE kitaplar.tur='Roman' AND kitaplar.fiyat > 40 ORDER BY kitaplar.fiyat DESC";
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});


const port=process.env.PORT || 8080;
app.listen(port);
console.log(`Example app listening at http://localhost:${port}`)
