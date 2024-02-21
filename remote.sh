while getopts 'uws' opt; do
  case "$opt" in
    u)
      echo "update web_control_rpi" &&
      mosquitto_pub -h 7291b266c672483184f1547a494a7620.s1.eu.hivemq.cloud -p 8883 -u kr315 -P ZZX00cvv -t /cmd/in -m "update"
      mosquitto_sub -h 7291b266c672483184f1547a494a7620.s1.eu.hivemq.cloud -p 8883 -u kr315 -P ZZX00cvv -t /cmd/out -C 3
      ;;

    w)
      echo "wake pc" &&
      mosquitto_pub -h 7291b266c672483184f1547a494a7620.s1.eu.hivemq.cloud -p 8883 -u kr315 -P ZZX00cvv -t /cmd/in -m "wake-pc"
      mosquitto_sub -h 7291b266c672483184f1547a494a7620.s1.eu.hivemq.cloud -p 8883 -u kr315 -P ZZX00cvv -t /cmd/out -C 3
      ;;

    s)
      echo "check status" &&
      mosquitto_sub -h 7291b266c672483184f1547a494a7620.s1.eu.hivemq.cloud -p 8883 -u kr315 -P ZZX00cvv -t /cmd/out
      ;;

    ?)
      echo "wrong parameter"
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"