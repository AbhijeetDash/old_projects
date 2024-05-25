const express = require('express')
const fs = require('fs')
const app = express()
const {MongoClient} = require('mongodb')

//Connection Properties;
const conUrl = "mongodb://127.0.0.1:27017"
const dbname = "FoodFeed"

app.get('/',(req, res)=>{
    res.setHeader('Access-Control-Allow-Origin', '*');
    var task="";
    MongoClient.connect(conUrl, {useNewUrlParser: true}, (error, client)=>{
        var db = client.db(dbname)
        if(error){
            return console.log("The error is \n"+error)
        }
        if(req.query.task){
            task = req.query.task

            if(task === 'login'){   
                var email = req.query.email
                var pass = req.query.pass
                db.collection('Users').findOne({Email: email, Password: pass}, (error, onValue)=>{
                   if(onValue == null){
                       res.send({
                        task : "No User"
                       })
                   } else {
                       var {Name, Profile} = onValue
                       res.send({
                        task:"Successfull",Name,Profile
                       })
                   }
               })              
            }


            if(task === 'create'){
                var email = req.query.email
                var pass = req.query.pass
                var name = req.query.name
                var pic = req.query.pic    
                db.collection('Users').findOne({Email: email}, (error, onValue)=>{
                    if(onValue == null) {
                        db.collection('Users').insertOne({
                            Name : name,
                            Email : email,
                            Password : pass,
                            Profile: pic 
                        })
                        res.send({
                            task : "Successfull",name,email,pic
                        })
                    } else {
                        res.send({
                            task : "Duplicate Entry Found" + error
                        })
                    }
                })
            }

            if(req.query.task == 'categoryList'){
                db.collection('Categories').find({}).toArray((error, onValue)=>{
                    if(onValue == null){
                        res.send({task : "No Category Found"})
                    } else {
                        res.send({onValue})
                    }
                })
            }

            if(req.query.task == 'addPrefs'){
                var email = req.query.email;
                var list = req.query.list;
                db.collection('Follow').insertOne({Email: email, Follow: list})
            }

            if(req.query.task == 'publish'){
                var {title, content, url, email} = req.query
                db.collection('Draft').deleteOne({Title : title, Email : email},(error, onValue)=>{
                    db.collection('Articles').insertOne({
                        Title : title,
                        Content : content,
                        Pic : url,
                        Email: email
                    })
                })
            }

            if(req.query.task == 'draft'){
                var {title, content, email} = req.query
                console.log(req.query)
                db.collection('Draft').insertOne({
                    Title: title,
                    Content: content,
                    Email: email
                })
            }

            if(req.query.task == 'getDraft'){
                var email = req.query.email
                db.collection('Draft').find({}).toArray((error, onValue)=>{
                    if(onValue == null){
                        res.send({task : "No Drafts Available"})
                    } else {
                        res.send({onValue})
                    }
                })
            }

            if(req.query.task == 'getArticles'){
                var article = [];
                db.collection('Articles').aggregate([
                    {
                        $lookup : {
                            from : 'Users',
                            localField : 'Email',
                            foreignField : 'Email',
                            as : 'Writter'
                        }
                    }
                ]).toArray((error, onValue)=>{
                    for(var i = 0; i < onValue.length; i++){
                        article.push({
                            title : onValue[i].Title,
                            content : onValue[i].Content,
                            url : onValue[i].Pic,
                            auth : onValue[i].Writter[0].Name,
                            pic : onValue[i].Writter[0].Profile,
                            length : onValue.length
                        })
                    }
                    res.send(article)
                })
            }

            if(req.query.task == 'getFollow'){
                var email = req.query.email
                var items = []
                var follows = []
                db.collection('Follow').findOne({Email : email}, (error, onValue)=>{
                    if(onValue != null){
                        var list = onValue.Follow
                        var cate = ''
                        for(var u = 0; u < list.length; u++){
                            if(list[u] != ' ' && list[u] != '[' && list[u] != ']' && list[u] != ','){
                                cate = cate+''+list[u]
                            } else if(list[u] == ' ' || list[u] == ']'){
                                items.push(cate)
                                cate = '';
                            }
                        }
                        for(var i = 0; i < items.length; i++){
                            db.collection('Categories').findOne({Category : items[i]}, (error, data)=>{
                                if(data != null){
                                    follows.push(data)
                                }
                                if(follows.length == items.length){
                                    res.send({follows,len:items.length})
                                }
                            })
                        }
                    }
                })
            }
        }
    })
})

app.listen(3000,()=>{
    console.log("localhost running")
})