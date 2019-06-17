<!DOCTYPE html>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="script.js"></script>
</head>
<body>
<div id="mainform">
<div class="innerdiv">
<!-- Required Div Starts Here -->
<h2>Form Validation Using AJAX</h2>
<form action='localhost:3000/divya/id' id="myForm" method='get' name="myForm">
<h3>Fill Your Information!</h3>
<table>
<tr>
<td>id</td>
<td><input id='id' name='text'  type='id'></td>
 <td>
<div id='id'></div>
</td>
</tr><br>
<tr>
<td>Username</td>
<td><input id='username1' name='username' onblur="validate('username', this.value)" type='text'></td>
<td>
<div id='username'></div>
</td>
</tr>
<tr>
<td>Password</td>
<td><input id='password1' name='password' onblur="validate('password', this.value)" type='password'></td>
<td>
<div id='password'></div>
</td>
</tr>
<tr>
<td>Email</td>
<td><input id='email1' name='email' onblur="validate('email', this.value)" type='text'></td>
<td>
<div id='email'></div>
</td>
</tr>
<tr>
<td>website</td>
<td><input id='website1' name='website' onblur="validate('website', this.value)" type='text'></td>
<td>
<div id='website'></div>
</td>
</tr>
</table>
<input onclick="checkForm()" type='submit' value='Submit'>submit
</form>
</div>
</body>
</html>


-----index.js

const http=require('http');
const express=require('express');
const app=express();

const mysql=require('mysql');
const bodyparser=require('body-parser');
//var path=require('path');
//const router=express.Router();

//router.get('divya/id',function(req,res){
 // res.sendfile(path.join(nodejs+'new.html'));
//});

var mysqlconnection=mysql.createConnection({
    host:'northside.in',
    user:'shakir',
    password: 'shakir123',
    database:'shakir_test',
    multipleStatements:true
});

mysqlconnection.connect((err)=>{
if(!err)
console.log('DB CONNECTIONs IS SUCCEDED');
else
console.log('db connection failed \n error:'+JSON.stringify(err,undefined,2));

});

  
  
  app.use(express.static('public'));
  app.set('view engine','ejs');
  app.use(bodyparser.json());
  app.use(express.json());
 
  
app.listen(3000,()=>console.log('express server'));
app.get('/',(req,res)=>{
  res.render('home');
});


app.get('/divya',(req,res)=>{
  mysqlconnection.query('select * from divya',(err,rows,fields)=>{
    if(!err)
    //console.log(rows[0].id);
    res.send(rows);
    else
    console.log(err);
  })
});
//get the id from user
app.get('/divya/id',(req,res)=>{
  var id=req.query.id;
  mysqlconnection.query('select * from divya where id=?',[req.query.id],(err,rows)=>{
    if(!err)
    //console.log(rows[0].id);
    res.send(rows);
    else
    console.log(err);
  })
});

//delete an data from user
app.delete('/divya/:id',(req,res)=>{
  mysqlconnection.query('delete from divya where id=?',[req.params.id],(err,rows,fields)=>{
    if(!err)
    //console.log(rows[0].id);
    res.send('deleted successfully');
    else
    console.log(err);
  })
});

app.post('/divya', (req, res)=>{
  var params=req.body;
  console.log(params);
  mysqlconnection.query('INSERT INTO divya SET ?',params,(error, results, fields)=> {
   if (error) throw error;
   res.end(json.stringify(results));
 })
});

app.put('/divya',(req, res)=> {
  mysqlconnection.query('update divya set name=? where id=?', [req.body.name,req.body.id] ,(error, results, fields)=> {
   if (error) throw error;
   res.end(json.stringify(results));
 })
});

-----style.css

@import "http://fonts.googleapis.com/css?family=Fauna+One|Muli";
#mainform{
width:960px;
margin:20px auto;
padding-top:20px;
font-family:'Fauna One',serif
}
#mainform h2{
width:100%;
float:left;
text-align:center;
margin-top:35px
}
.innerdiv{
width:65%;
float:left
}
form{
background-color:#fff;
color:#123456;
box-shadow:0 1px 1px 1px gray;
width:500px;
margin:50px 250px 0 50px;
float:left;
height:400px;
padding:10px
}
h3{
margin-top:0;
color:#fff;
background-color:#0B87AA;
text-align:center;
width:100%;
height:50px;
padding-top:30px
}
input{
width:250px;
height:30px;
margin-top:10px;
border-radius:3px;
padding:2px;
box-shadow:0 1px 1px 0 #a9a9a9;
margin:10px
}
input[type=button]{
background-color:#0B87AA;
border:1px solid #fff;
font-family:'Fauna One',serif;
font-weight:700;
font-size:18px;
color:#fff;
width:50%;
margin-left:105px;
margin-top:30px
}
span{
color:green
}
#myForm div{
color:red;
font-size:14px
}

----validate.php
<?php
$value = $_GET['query'];
$formfield = $_GET['field'];
// Check Valid or Invalid user name when user enters user name in username input field.
if ($formfield == "username") {
if (strlen($value) < 4) {
echo "Must be 3+ letters";
} else {
echo "<span>Valid</span>";
}
}
// Check Valid or Invalid password when user enters password in password input field.
if ($formfield == "password") {
if (strlen($value) < 6) {
echo "Password too short";
} else {
echo "<span>Strong</span>";
}
}
// Check Valid or Invalid email when user enters email in email input field.
if ($formfield == "email") {
if (!preg_match("/([w-]+@[w-]+.[w-]+)/", $value)) {
echo "Invalid email";
} else {
echo "<span>Valid</span>";
}
}
// Check Valid or Invalid website address when user enters website address in website input field.
if ($formfield == "website") {
if (!preg_match("/b(?:(?:https?|ftp)://|www.)[-a-z0-9+&@#/%?=~_|!:,.;]*[-a-z0-9+&@#/%=~_|]/i", $value)) {
echo "Invalid website";
} else {
echo "<span>Valid</span>";
}
}
?>



