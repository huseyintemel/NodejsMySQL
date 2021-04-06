var mysql=require('mysql');

var baglanti=mysql.createConnection({
    host:"localhost",
    user:"root",
    password:"",
    database:"nodejs"    
});

baglanti.connect(function(err){
    console.log("Connected!");
    /*
    var sql = "CREATE TABLE product (product_id INT(11) PRIMARY KEY AUTO_INCREMENT, product_name VARCHAR(200), product_price INT(11))";
    baglanti.query(sql, function (err, result) {
    if (err) throw err;
    console.log("Table created");  
});
*/
var sql = "INSERT INTO product(product_name,product_price) VALUES ?";
var values=[
    ['Product 1','2000'],
    ['Product 2','5000'],
    ['Product 3','4000'],
    ['Product 4','6000'],
    ['Product 5','7000']
];

baglanti.query(sql,[values],function (err, result) {
  if (err) throw err;
  console.log("Number of records inserted: " + result.affectedRows);
});
});




var sorgu="SELECT * FROM ogrenciler ORDER BY name";

baglanti.query(sorgu,function(err,result,fields){
    if(err) throw err;
    console.log(result); 
});



