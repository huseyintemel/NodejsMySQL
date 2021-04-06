const express = require("express");
const app = express();
var mysql=require('mysql');

app.use(express.json());

var baglanti=mysql.createConnection({
    host:"localhost",
    user:"root",
    password:"",
    database:"satıs"    
});

baglanti.connect((err) =>{
    if(err) throw err;
    console.log('Mysql Connected...');
});

//Index page
app.get("/",function(req,res){
    res.send("Index sayfası");
});

// showing all sales
app.get('/sales',(req, res) => {
    let sql = "SELECT * FROM sales";
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

// showing selected sale
app.get('/sales/:id',(req, res) => {
    let sql = "SELECT * FROM sales WHERE purchase_number="+req.params.id;
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

//posting a sale
app.post('/sales',(req, res) => {
    let data = {date_of_purchase: req.body.date_of_purchase, customer_id : req.body.customer_id , item_code: req.body.item_code};
    let sql = "INSERT INTO sales SET ?";
    let query = baglanti.query(sql, data,(err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

//deleting a sale
app.delete('/sales/:id',(req, res) => {
    let sql = "DELETE FROM sales WHERE purchase_number="+req.params.id+"";
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

// showing purchase date,customer name,customer_id and purchased item with multiple join
app.get('/purchasedetail',(req, res) => {
    let sql = "SELECT sales.date_of_purchase,customers.customer_id,customers.name,items.item FROM sales INNER JOIN customers ON sales.customer_id = customers.customer_id INNER JOIN items ON sales.item_code = items.item_code";
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

// showing average price for each company with inner join and group by
app.get('/purchasedetail',(req, res) => {
    let sql = "SELECT companies.company_name, AVG(items.item_price) as avg_price FROM companies INNER JOIN items ON companies.company_id = items.company_id GROUP BY companies.company_id";
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

// showing purchase_number,purchased item names for given name
app.get('/purchasesforperson',(req, res) => {
    let sql = "SELECT sales.purchase_number,items.item,customers.name FROM sales INNER JOIN items ON sales.item_code = items.item_code INNER JOIN customers ON customers.customer_id = sales.customer_id WHERE customers.name='Matthew K. Atwood'";
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});

// showing purchased item count and customer name all customers
app.get('/purchasecount',(req, res) => {
    let sql = "SELECT customers.name,COUNT(items.item) as purchase_count FROM sales INNER JOIN items ON sales.item_code = items.item_code INNER JOIN customers ON customers.customer_id = sales.customer_id GROUP BY customers.name";
    let query = baglanti.query(sql, (err, results) => {
        if(err) throw err;
        res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
    });
});


const port=process.env.PORT || 8080;
app.listen(port);
console.log(`Example app listening at http://localhost:${port}`);