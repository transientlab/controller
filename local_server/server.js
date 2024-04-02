// _ t r a n s i e n t l a b
// Author: Paweł Kreis
// pawel@transientlab.net
//
// THIS CODE IS COPYRIGHTED 
// YOU ARE NOT ALLOWED TO COPY OR USE THE CODE WITHOUT DISCUSSING IT WITH THE AUTHOR
//
// Show controller system
//
// : connect.js : webserver setup


const express = require('express');
const { exec } = require('child_process');
const fs = require('fs');

const app = express();
const port = 3000;

// serve the index.html file
app.get('/', (req, res) => {
  fs.readFile('index.html', 'utf8', (err, data) => {
    if (err) {
      console.error('Error reading index.html:', err);
      res.sendStatus(500);
    } else {
      res.send(data);
    }
  });
});

// respond with command execution
app.get('/command/:comm_id', (req, res) => {
  console.log(req.params)
  const shellScript = `command.sh -${req.params['comm_id']}`;

  exec(`/bin/bash ../${shellScript}`, (error, stdout, stderr) => {
    if (error) {
      console.error('error: ', error);
      res.sendStatus(500);
    } else {
      console.log(shellScript);
      res.sendStatus(200);
    }
  });

  // // window.setTimeout(function(){window.location.href = "192.168.0.65";}, 3000);
  // // for compatibility with iPad3
  // fs.readFile('index.html', 'utf8', (err, data) => {
  //   if (err) {
  //     console.error('Error reading index.html:', err);
  //     res.sendStatus(500);
  //   } else {
  //     res.send(data);
  //   }
  // });  

});

// respond with data
app.get('/read/:id', (req, res) => {
  console.log(req.params);
  if (req.params['id'] == 'temp') {
    fs.readFile('/sys/class/thermal/thermal_zone0/temp', 'utf8', (err, data) => {
      res.send(data);
      console.log(data);
    });  
  }
  if (req.params['id'] == 'date') {
    exec(`date`, (error, stdout, stderr) => {
      if (error) {
        console.error('error: ', error);
        res.sendStatus(500);
      } else {
        res.send(stdout);
      }
    });
  }
  
});

app.use('/static', express.static('static'));

// start the server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});