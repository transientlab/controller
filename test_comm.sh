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