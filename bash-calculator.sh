#!/bin/bash
sudo apt install bc || pkg install bc
echo -e  "\e[36;1;40m A Menu Based Calculator. \e[0m"
echo -e "\e[36;1;40m Below  operatation can be performed using operators.\n{1} Add\n{2} Subtract\n{3} Multiply\n{4} Division\n{5} Exponentiation(Number1 ≤ 3037000499 & Number2 ≥ 2)\n{6} GCD\n{7} LCM\n{8} ᵏ√n(ᵏ = number2)<Accuracy = till decimal 3 places>\n{9} Ratio\n{10} nPr<n=Number1, r=Number2>\n{11} nCr\n{12} Average\n{13} Area of Triangle\n{14} Hypotenuse\n{15} Simple Interest<time=1>\n{16} Geometric Mean\n{17} Harmonic Mean\n{18} Modulus\n{19} RMS (Root Mean Square)\n{20} Contraharmonic Mean\n{21} Base64 encoder/decoder<Number 1 : 1 for encode, 2 for decode>\n{22} Exit. \e[0m"
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
    echo "" "Divided by $i"
    )
    echo "$temp" | grep -E '(\.000.*\.000)'
   done | echo "HCF= "$(sed -n '$s/.*\([0-9]\+\)$/\1/p')
 ;;
 7)
#greater smaller Decider
    if [[ "$number1" -gt "$number2" ]]; then
     greater_number=$number1
     smaller_number=$number2
    elif [[ "$number1" == "$number2"  ]]; then
     echo "LCM is ${number1}"
    else
     greater_number=$number2
     smaller_number=$number1
    fi
#end greater smaller decider
    hcff=$(
    for i in $(seq 1 "$smaller_number"); do      temp=$(
     echo -n $(echo "scale=3; $number1 / $i" | bc)
     echo -n "" $(echo "scale=3; $number2 / $i" | bc)
     echo "" "Divided by $i" )
     echo "$temp" | grep -E '(\.000.*\.000)'
    done | sed -n '$s/.*\([0-9]\+\)$/\1/p')
   lcm=$(echo  "($number1 * $number2) / $hcff" | bc)
   echo "LCM : $lcm"
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
  if [[ "$number1" -gt "$number2" ]]; then
       greater_number=$number1
       smaller_number=$number2
      elif [[ "$number1" == "$number2"  ]]; then
       echo "LCM is ${number1}"
      else
       greater_number=$number2
       smaller_number=$number1
      fi
  for i in $(seq 2 "$smaller_number"); do
   first_div=$(echo " $number1 % $i " |bc)
   second_div=$(echo " $number2 % $i"|bc)
  if [[ "$first_div" == "0" && "$second_div" == "0"  ]]; then
   numerator=$(echo $((number1 / i)))
   denominator=$(echo $((number2 / i)))
   echo "Ratio = " "$numerator : $denominator"
  fi
  done | tail -n 1
 ;;
 10)
   kd=$(
  for i in $(seq 0 $(($number2 - 1))); do
   echo "$number1 - $i" | bc
  done)
#The code to do multipy all terms in the varibale kd
  product=1
  while read -r num; do
    product=$(echo "$product * $num" | bc)
  done <<< "$kd"
  echo "nPr = " $product
#End Comment
 ;;
 11)
#NPR
  kd=$(
   for i in $(seq 0 $(($number2 - 1))); do
    echo "$number1 - $i" | bc
   done)
 #The code to do multipy all terms in the varibale kd
   product=1
   while read -r num; do
     product=$(echo "$product * $num" | bc)
   done <<< "$kd"
   npr=$(echo $product)
#End NPR
#For r!
     ka=$(
    for i in $(seq 0 $(($number2 - 1))); do
     echo "$number2 - $i" | bc
    done)
  #The code to do multipy all terms in the varibale kd
    product=1
    while read -r num; do
      product=$(echo "$product * $num" | bc)
    done <<< "$ka"
    r_fact=$(echo $product)
#for r!
   echo "nCr : " $(($npr / $r_fact))
#formula using nCr= nPr/r!
 ;;
 12)
  echo -n "Average : " 
  echo " ($number1 + $number2) / 2" | bc
 ;;
 13)
  echo -n "Area of Triangle = "
  echo "($number1 * $number2) / 2" |  bc
 ;;
 14)
  ke=$( echo " $((number1 * number1)) + $((number2 * number2))" | bc)
  sqrt() { echo "sqrt($1)" | bc -l; }
  echo -n "Hypotenuse = "
  sqrt "$ke"
 ;;
 15)
  echo -n "Simple Interest = "
  echo  " scale=3; ($number1 * $number2) / 100" | bc
 ;;
 16)
  kf=$( echo "$number1 * $number2" | bc)
  sqrt() { echo "sqrt($1)" | bc -l; }
   echo -n "Geometric Mean = "
   sqrt "$kf"
 ;;
 17)
  echo -n "Harmonic Mean = "
  kf=$(echo "2 * $number1 * $number2"|bc)
  kg=$(echo "($number1 + $number2)" | bc)
  echo " scale=3; $kf / $kg" | bc
 ;;
 18)
  echo -n "Modulus : "
  echo "$number1 % $number2" | bc
 ;;
 19)
  kh=$( echo "$((number1 * number1)) + $((number2 * number2))" | bc )

  sqrt() { echo "sqrt($1)" | bc -l; }

  echo -n "RMS (Root Mean Square) = "

  ki=$(sqrt "$(echo "scale=6; $kh / 2" | bc -l)")

  echo "scale=3; $ki" | bc
 ;;
 20)
  ki=$( echo "$((number1 * number1)) + $((number2 * number2))" | bc )
  kj=$(echo "$number1 + $number2" | bc)
  echo -n "Contraharmonic Mean = "
  echo "scale=3; $ki / $kj" | bc
 ;;
 21)
  if [[ "$number1" == "1" ]]; then
    echo -n "Enter Text to encode : "
    echo  "$number2" | base64
  else
    echo -n "Enter Text to Decode : "
    echo "$number2" | base64 -d
  fi
 ;;
 22)
  exit
 ;;
 *)
  echo "Kindly choose the correct choice"
esac 
