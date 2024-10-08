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
  echo "in" > $GPIO_PATH/gpio$1/direction
}

pin_state_get()
{
    if grep -q 0 $GPIO_PATH/gpio$1/value; then 
      return 0
    else 
      return 1 
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

  pin_export "2"
  pin_conf_output "2"
  sleep 0.1

  pin_export "3"
  pin_conf_output "3"
  sleep 0.1

  pin_export "14"
  pin_conf_output "14"
  sleep 0.1

  pin_export "15"
  pin_conf_output "15"
  sleep 0.1

  pin_export "17"
  pin_conf_output "17"
  sleep 0.1

  pin_export "27"
  pin_conf_output "27"
  sleep 0.1

  pin_export "22"
  pin_conf_output "22"
  sleep 0.1

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

# pins_configure_all
while getopts 'h:g:nfmpskrliqabcdu' opt; do
  case "$opt" in
    # FNIP 8x16A - relays
    h)
      case "$OPTARG" in
        [1-8]*)
          number="$OPTARG"
          echo -n -e "FN,ON,$number\r\n" | nc 174.128.0.102 7078 -w 1
          ;;
        *)
          echo "there are only 8 relays (1-8), not $OPTARG" >&2
          exit 1
          ;;
      esac
      ;;
    g)
      case "$OPTARG" in
        [1-8]*)
          number="$OPTARG"
          echo -n -e "FN,OFF,$number\r\n" | nc 174.128.0.102 7078 -w 1
          ;;
        *)
          echo "there are 8 relays (1-8), not $OPTARG" >&2
          exit 1
          ;;
      esac
      ;;

   
    # Panasonic PT-RQ
    n)
      echo -n -e "\x25\x31\x50\x4f\x57\x52\x20\x31\x0d\x0a" | nc -w 3 192.168.0.102 4352
      ;;

    f)
      echo -n -e "\x25\x31\x50\x4f\x57\x52\x20\x30\x0d\x0a" | nc -w 3 192.168.0.102 4352
      ;;

    # Meyer Galileo
    m)
      echo "/processing/input/\d/mute="true"" | nc -w 3 192.168.0.28 25003
      ;;
    q)
      echo "/processing/input/\d/gain="-12"" | nc -w 3 192.168.0.28 25003
      ;;
    
    # Hyperdeck Studio Pro
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

    # RPi GPIO
    a)
      pin_state_toggle "2"
      ;;
    b)
      date | nc -w 1 174.128.0.4 11001 -u
      ;;
    c)
      
      ;;
    d)
      
      ;;

    # update from git
    u)
      git fetch --all &&
      git reset --hard origin/main &&
      cp -r systemd_services/* /etc/systemd/system &&
      systemctl daemon-reload
      ;;

    ?)
      echo "wrong parameter" &
      exit 1
      ;;

  esac
done
shift "$(($OPTIND -1))"
