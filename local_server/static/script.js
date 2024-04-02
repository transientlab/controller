
// confirm OFF
function confirm_cmd(cmd) {
  if (confirm("Are you sure?") == true) {
    command(cmd);
  } else {
    alert('Cancelled')
  }
}

// request shell script execution on server
function command(comm_id) {
  console.log('command: ' + comm_id)
  fetch('/command/' + comm_id)
    .then(response => {
      if (response.ok) {
        console.log('ok')
      } else {
        alert('failed');
        console.error('response error:', comm_id);
      }
    })
    .catch(error => {
      console.error('no response:', error, comm_id);
      alert('failed');
    });

}

// request shell script execution on server with params
function commandX(comm_id, var1) {
  fetch('/commandX/' + comm_id + '/' + var1)
    .then(response => {
      if (response.ok) {
        // alert('ok');
      } else {
        // alert('fail');
      }
    })
    .catch(error => {
      console.error('Error:', error, comm_id);
      // alert('error');
    });
}

// request data from server
function read(id) {
  fetch('/read/' + id)
    .then((response) => response.text())
    .then((text) =>
    {
      if(id == 'temp') {
      console.log('temp', text)
      let div=document.getElementById('pi_temp');
      div.innerHTML='CPU temp: ' + parseInt(text)/1000 + ' °C';
      }
      if(id == 'date') {
        console.log('date', text)
        let div=document.getElementById('date');
        div.innerHTML=text;
        }
    })
    .catch(error => {
      console.error('Error:', error);
      // alert('error');
    });
}

function read_data() {
  read('date');
  read('temp');
}
