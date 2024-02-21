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