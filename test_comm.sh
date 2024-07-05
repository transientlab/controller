while getopts 'nfmpskrlbq' opt; do
  case "$opt" in
    n)
        echo "n" 
        ;;

    f)
      echo "f"
      ;;

    m)
      echo "m"
      ;;

    p)
      echo "p"
      ;;

    s)
      echo "s"
      ;;

    k)
      echo "k"
      ;;

    r)
      echo "r"
      ;;

    l)
      echo "l"
      ;;

    b)
      echo "b"
      ;;

    q)
      echo "q"
      ;;

    ?)
      echo "wrong parameter" &
      exit 1
      ;;

  esac
done
shift "$(($OPTIND -1))"