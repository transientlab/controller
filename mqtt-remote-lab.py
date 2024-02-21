import subprocess
from time import sleep
import datetime

broker_url = '7291b266c672483184f1547a494a7620.s1.eu.hivemq.cloud'
broker_port = 8883
broker_user = 'kr315'
broker_pass = 'ZZX00cvv'
in_msg_channel = '/cmd/in'
out_msg_channel = '/cmd/out'
msg_count = 1

# report activity
report_msg = datetime.datetime.now().strftime("%d/%m/%Y %H:%M:%S") + " READY"
report = f'mosquitto_pub -h {broker_url} -p {broker_port} -u {broker_user} -P {broker_pass} -t {out_msg_channel} -m "{report_msg}"'
out = subprocess.check_output(report, shell=True, timeout=10)

# wait for new message
retreive = f'mosquitto_sub -h {broker_url} -p {broker_port} -u {broker_user} -P {broker_pass} -t {in_msg_channel} -C {msg_count}'
msg = subprocess.check_output(retreive, shell=True, timeout=30).decode('utf-8').strip()
print(msg)

# interpret the message or redirect to stdin
if msg == "update":
    # cmd = "git clone git@github.com:transientlab/web_control_rpi.git"
    cmd = "git fetch --all && git reset --hard origin/main"
    print("repo updated")
elif msg == "wake-pc":
    cmd = "wakeonlan E0:D5:5E:41:6A:65"
else:
    cmd = msg

# send command confirmation
confirm = f'mosquitto_pub -h {broker_url} -p {broker_port} -u {broker_user} -P {broker_pass} -t {out_msg_channel} -m "executing: {cmd}"'
out = subprocess.check_output(confirm, shell=True, timeout=10)

sleep(1)

# send command response
response = subprocess.check_output(cmd, shell=True, timeout=30).decode('utf-8').strip()
respond = f'mosquitto_pub -h {broker_url} -p {broker_port} -u {broker_user} -P {broker_pass} -t {out_msg_channel} -m "{response}"'
out = subprocess.check_output(respond, shell=True, timeout=10)
print(out)
