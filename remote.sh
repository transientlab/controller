while getopts 'uws' opt; do
  case "$opt" in
    u)
      echo "update web_control_rpi" &&
      mosquitto_pub -h  -p 8883 -u  -P  -t /cmd/in -m "update" &
      mosquitto_sub -h  -p 8883 -u  -P  -t /cmd/out -C 3
      ;;

    w)
      echo "wake pc" &&
      mosquitto_pub -h  -p 8883 -u  -P  -t /cmd/in -m "wake-pc" &
      mosquitto_sub -h  -p 8883 -u  -P  -t /cmd/out -C 3
      ;;

    s)
      echo "check status" &&
      mosquitto_sub -h  -p 8883 -u  -P  -t /cmd/out
      ;;

    ?)
      echo "wrong parameter"
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"
