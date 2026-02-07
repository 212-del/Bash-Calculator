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
    elif [[ $number4 = "1" ]]; then
        echo "$number3"
        echo "${number3}^${number4} = "$((number3 ** number4))
    else
        echo "Number1 is Invalid"
    fi
  fi
 ;;
 6)
   if [[ "$number3" -gt "$number4" ]]; then
    greater_number=$number3
    smaller_number=$number4
   elif [[ "$number3" == "$number4"  ]]; then
    echo "HCF is ${number3}"
   else
    greater_number=$number4
    smaller_number=$number3
   fi
   for i in $(seq 1 "$smaller_number"); do
    temp=$(
    echo -n $(echo "scale=3; $number3 / $i" | bc) 
    echo -n "" $(echo "scale=3; $number4 / $i" | bc)
    echo "" "Divided by $i"
    )
    echo "$temp" | grep -E '(\.000.*\.000)'
   done | echo "HCF= "$(sed -n '$s/.*\([0-9]\+\)$/\1/p')
 ;;
 7)
  exit
 ;;
 *)
  echo "Kindly choose the correct choice"
esac
