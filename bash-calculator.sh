#!/bin/bash
sudo apt install bc || pkg install bc
echo -e  "\e[36;1;40m A Menu Based Calculator. \e[0m"
echo -e "\e[36;1;40m Below  operatation can be performed using operators.\n{1} Add\n{2} Subtract\n{3} Multiply\n{4} Division\n{5} Exponentiation(Number1 ≤ 3037000499 & Number2 ≥ 2)\n{6} GCD\n{7} LCM\n{8} ᵏ√n(ᵏ = number2)<Accuracy = till decimal 3 places>\n{9} Exit. \e[0m"
until [[ $number1 =~ ^-?[0-9]+$ ]]; do
 read -r -p "   Enter Number1: " number1
done
read -r -p  "   Enter Choice: " Choice1
until [[ $number2 =~ ^-?[0-9]+$ ]]; do
 read -r -p "   Enter Number2: " number2
done
case ${Choice1} in
 1)
  echo "${number1} + ${number2} = "$((${number1} + ${number2}))
 ;;
 2)
  echo "${number1} - ${number2} = "$((number1 - number2))
 ;;
 3)
  echo "${number1} * ${number2} = "$((number1 * number2))
 ;;
 4)
  echo "${number1} ÷ ${number2} = "$(echo "scale=2; $number1 / $number2" | bc)
 ;;
 5)
  if [[ $number1 -le 3037000499 ]]; then
    if [[ $number2 -ge 2 ]]; then
       echo "${number1}^${number2} = "$((number1 ** number2))
    elif [[ $number2 == "1" ]]; then
      echo "${number1}^${number2} = "$((number1 ** number2))
    elif [[ $number2 == "0"  ]]; then
      echo "${number1}^${number2} = "$((number1 ** number2))  
    else
        echo "Number1 is Invalid"
    fi
  fi
 ;;
 6)
   if [[ "$number1" -gt "$number2" ]]; then
    greater_number=$number1
    smaller_number=$number2
   elif [[ "$number1" == "$number2"  ]]; then
    echo "HCF is ${number1}"
   else
    greater_number=$number2
    smaller_number=$number1
   fi
   for i in $(seq 1 "$smaller_number"); do
    temp=$(
    echo -n $(echo "scale=3; $number1 / $i" | bc) 
    echo -n "" $(echo "scale=3; $number2 / $i" | bc)
    echo  " Divided by $i"
    )
    echo "$temp" | grep -E '(\.000.*\.000)'
   done | echo "HCF= "$(sed -n '$s/.*\([0-9]\+\)$/\1/p')
 ;;
 7)
   if [[ "$number1" -gt "$number2" ]]; then
      greater_number=$number1
      smaller_number=$number2
   elif [[ "$number1" == "$number2"  ]]; then
      echo "LCM is ${number1}"
   else
      greater_number=$number2
      smaller_number=$number1
   fi
     hcff=$(
     for i in $(seq 1 "$smaller_number"); do
      temp=$(
      echo -n $(echo "scale=3; $number1 / $i" | bc) 
      echo -n "" $(echo "scale=3; $number2 / $i" | bc)
      echo  " Divided by $i"
      )
      echo "$temp" | grep -E '(\.000.*\.000)'
     done | sed -n '$s/.*\([0-9]\+\)$/\1/p')
     product_lcm=$(( number1 * number2 ))
     echo "LCM = " $(( product_lcm / hcff))
 ;;
 8)
  old_threshold="1"
  new_threshold=""
  assume="2"
  while [[ "${old_threshold}" != "${new_threshold}" ]]; do
   if [[ $number2 -ge "2" ]]; then
    first_sum(){
     echo "($number2 - 1) * $assume" | bc
}
    second_sum(){
     echo " scale=3; $number1 / $assume^($number2 - 1)" | bc
}
    assume=$(echo "scale=3; ($(first_sum) + $(second_sum)) / $number2" | bc)
    old_threshold="$assume"
     first_sum(){
      echo " scale=3; ($number2 - 1) * $assume" | bc
}
     second_sum(){ 
      echo " scale=3; $number1 / $assume ^ $(($number2 - 1))" | bc
 }
    assume=$(echo "scale=3; ($(first_sum) + $(second_sum)) / $number2" | bc)
    new_threshold="$assume" 
    echo "$new_threshold" 
   else
    echo "Number2 > 2"
   fi
  sleep .1
  done |  printf "%s" "$(tail -n 1)"; echo -n " is the ${number2}th root of ${number1}"
 ;;
 9)
  exit
 ;;
 *)
  echo "Kindly choose the correct choice"
esac
