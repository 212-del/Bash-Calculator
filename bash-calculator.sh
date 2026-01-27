#!/bin/bash
sudo apt install bc || pkg install bc
echo -e  "\e[31;23;222m A Menu Based Calculator. \e[0m"
echo -e "\e[31;3;134m Below  operatation can be performed using operators.\n{1} Add\n{2} Subtract\n{3} Multiply\n{4} Division\n{5} Exponentiation(Number1 ≤ 3037000499 & Number2 ≥ 2)\n{6} GCD\n{7} Exit. \e[0m"
until [[ $number3 =~ ^-?[0-9]+$ ]]; do
 read -r -p "   Enter Number1: " number3
done
read -r -p  "   Enter Choice: " Choice1
until [[ $number4 =~ ^-?[0-9]+$ ]]; do
 read -r -p "   Enter Number2: " number4
done
case ${Choice1} in
 1)
  echo "${number3} + ${number4} = "$((${number3} + ${number4}))
 ;;
 2)
  echo "${number3} - ${number4} = "$((number3 - number4))
 ;;
 3)
  echo "${number3} * ${number4} = "$((number3 * number4))
 ;;
 4)
  echo "${number3} ÷ ${number4} = "$(echo "scale=2; $number3 / $number4" | bc)
 ;;
 5)
  if [[ $number3 -le 3037000499 ]]; then
    if [[ $number4 -ge 2 ]]; then
        echo "${number3}^${number4} = "$((number3 ** number4))
    else
        echo "Number1 is Invalid"
    fi
  fi
 ;;
 6)
   if [[ $number3 -gt $number4 ]]; then
   larger_num=$number3
   smaller_num=$number4
  elif [[ $number3 == $number4 ]]; then
   echo "GCD=$number3"
  else
    larger_num=$number4
    smaller_num=$number3
  fi
  limit=$((smaller_num / 2))
  for i in $(seq 1 "$limit")
  do
    echo -n "$(echo "scale=3; $number3 / $i" | bc | awk '{print $1, $2}' | grep  ".000")"
    echo -n "" "$(echo "scale=3; $number4 / $i" | bc | awk '{print $1, $2}' | grep  ".000")"
    echo "" "Both number divided by $i"
  done
 ;;
 7)
  exit
 ;;
esac
