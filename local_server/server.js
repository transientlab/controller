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

// respond with script execution
app.get('command/:id/', (req, res) => {
  console.log(req.params)
  const shellScript = `test_comm.sh -${req.params['id']}`;

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

app.use('/static', express.static('static'));

// start the server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});