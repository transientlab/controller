
// confirm OFF
function confirm_off() {
  if (confirm("Are you sure?") == true) {
    command('f');
  } else {
    alert('Cancelled')
  }
}

// request shell script execution on server
function command(comm_id) {
  fetch('/command/' + comm_id)
    .then(response => {
      if (response.ok) {
        alert('ok');
        
      } else {
        alert('fail');
        console.error('Error:', comm_id);
      }
    })
    .catch(error => {
      console.error('Error:', error, comm_id);
      alert('error');
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


var el = document.getElementById("timer");
var i = 0;

function counter() {
  el.innerHTML = i++;
  if (i <= 10) {
    setTimeout(counter, 1000);
  }
}

counter();