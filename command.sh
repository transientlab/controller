# _ t r a n s i e n t l a b
# Author: Paweł Kreis
# pawel@transientlab.net
#
# THIS CODE IS COPYRIGHTED 
# YOU ARE NOT ALLOWED TO COPY OR USE THE CODE WITHOUT DISCUSSING IT WITH THE AUTHOR
#
# Show controller system
# : command.sh : os commands for controlling devices
# 


# GPIO functions
GPIO_PATH=/sys/class/gpio

pin_export()
{
    if [ ! -e $GPIO_PATH/gpio$1 ]; then
    echo $1 > $GPIO_PATH/export
    fi
}

pin_conf_output()
{
  sudo echo "out" > $GPIO_PATH/gpio$1/direction
}

pin_conf_input()
{
  echo "out" > $GPIO_PATH/gpio$1/direction
}

pin_state_get()
{
    if grep -q 0 $GPIO_PATH/gpio$1/value
    then return 0
    else return 1 
    fi 
}

pin_state_set_on()
{
  echo "1" > $GPIO_PATH/gpio$1/value
}

pin_state_set_off()
{
  echo "0" > $GPIO_PATH/gpio$1/value
}

pin_state_toggle()
{
    if pin_state_get "$1" == 0; then
    pin_state_set_on "$1"
    else
    pin_state_set_off "$1"
    fi
}

pins_configure_all()
{
  # relay 1
  pin_export "2"
  pin_conf_output "2"
  sleep 0.1
  # relay 2
  pin_export "3"
  pin_conf_output "3"
  sleep 0.1
  # relay 3
  pin_export "14"
  pin_conf_output "14"
  sleep 0.1
  # relay 4
  pin_export "15"
  pin_conf_output "15"
  sleep 0.1
  # relay 5
  pin_export "17"
  pin_conf_output "17"
  sleep 0.1
  # relay 6
  pin_export "27"
  pin_conf_output "27"
  sleep 0.1
  # relay 7
  pin_export "22"
  pin_conf_output "22"
  sleep 0.1
  # relay 8
  pin_export "23"
  pin_conf_output "23"
  sleep 0.1
}

pin_test_output() {
    pin_state_set_off "$1"
    sleep 0.2
    pin_state_toggle "$1"
    sleep 0.2
    pin_state_toggle "$1"
    sleep 0.2
}

while getopts 'unfmpskrlbq' opt; do
  case "$opt" in
    u)
      git fetch --all &&
      git reset --hard origin/main &&
      sudo cp -r systemd_services/* /etc/systemd/system &&
      sudo systemctl daemon-reload
      ;;
    n)
      echo -n -e "\x25\x31\x50\x4f\x57\x52\x20\x31\x0d\x0a" | nc -w 3 192.168.0.101 4352 &
      echo -n -e "\x25\x31\x50\x4f\x57\x52\x20\x31\x0d\x0a" | nc -w 3 192.168.0.102 4352 &
      echo "/processing/input/\d/mute="false"" | nc -w 3 192.168.0.28 25003 &
      echo "play: loop: true" | nc -w 3 192.168.0.59 9993
      ;;

    f)
      echo -n -e "\x25\x31\x50\x4f\x57\x52\x20\x30\x0d\x0a" | nc -w 3 192.168.0.101 4352 &
      echo -n -e "\x25\x31\x50\x4f\x57\x52\x20\x30\x0d\x0a" | nc -w 3 192.168.0.102 4352 &
      echo "/processing/input/\d/mute="true"" | nc -w 3 192.168.0.28 25003 &
      echo "stop" | nc -w 3 192.168.0.59 9993
      ;;

    m)
      echo "/processing/input/\d/mute="true"" | nc -w 3 192.168.0.28 25003
      ;;

    p)
      echo "play: loop: true" | nc -w 3 192.168.0.59 9993
      ;;

    s)
      echo "stop" | nc -w 3 192.168.0.59 9993
      ;;

    k)
      echo "play: speed: 1000" | nc -w 3 192.168.0.59 9993
      ;;

    r)
      echo "play: speed: -1000" | nc -w 3 192.168.0.59 9993
      ;;

    l)
      echo "/processing/input/\d/gain="0"" | nc -w 3 192.168.0.28 25003
      ;;

    b)
      echo "/processing/input/\d/gain="-6"" | nc -w 3 192.168.0.28 25003
      ;;

    q)
      echo "/processing/input/\d/gain="-12"" | nc -w 3 192.168.0.28 25003
      ;;

    ?)
      echo "wrong parameter" &
      exit 1
      ;;

  esac
done
shift "$(($OPTIND -1))"
