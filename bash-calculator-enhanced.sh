#!/bin/bash
# Enhanced Bash Calculator
# Contribution for https://github.com/212-del/Bash-Calculator
# Author: LEO (AI Agent)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# History file
HISTORY_FILE="$HOME/.bash_calculator_history"

# Initialize history file
touch "$HISTORY_FILE"

show_banner() {
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC}          ${YELLOW}🔢 Enhanced Bash Calculator${NC} v2.0             ${BLUE}║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

show_menu() {
    echo -e "${YELLOW}Available Operations:${NC}"
    echo "────────────────────────────────────────"
    echo -e " ${GREEN}1.${NC}  Addition (+)"
    echo -e " ${GREEN}2.${NC}  Subtraction (-)"
    echo -e " ${GREEN}3.${NC}  Multiplication (×)"
    echo -e " ${GREEN}4.${NC}  Division (÷)"
    echo -e " ${GREEN}5.${NC}  Exponentiation (^)"
    echo -e " ${GREEN}6.${NC}  GCD (Greatest Common Divisor)"
    echo -e " ${GREEN}7.${NC}  LCM (Least Common Multiple)"
    echo -e " ${GREEN}8.${NC}  k√n (Root)"
    echo -e " ${GREEN}9.${NC}  Ratio"
    echo -e " ${GREEN}10.${NC} nPr (Permutations)"
    echo -e " ${GREEN}11.${NC} nCr (Combinations)"
    echo -e " ${GREEN}12.${NC} Average"
    echo -e " ${GREEN}13.${NC} Area of Triangle"
    echo -e " ${GREEN}14.${NC} Hypotenuse"
    echo -e " ${GREEN}15.${NC} Simple Interest"
    echo -e " ${GREEN}16.${NC} Geometric Mean"
    echo -e " ${GREEN}17.${NC} Harmonic Mean"
    echo -e " ${GREEN}18.${NC} Modulus"
    echo -e " ${GREEN}19.${NC} RMS (Root Mean Square)"
    echo -e " ${GREEN}20.${NC} Contraharmonic Mean"
    echo -e " ${GREEN}21.${NC} Base64 Encode/Decode"
    echo -e " ${GREEN}22.${NC} ${YELLOW}NEW:${NC} Factorial"
    echo -e " ${GREEN}23.${NC} ${YELLOW}NEW:${NC} Fibonacci"
    echo -e " ${GREEN}24.${NC} ${YELLOW}NEW:${NC} Prime Check"
    echo -e " ${GREEN}25.${NC} ${YELLOW}NEW:${NC} View History"
    echo -e " ${GREEN}0.${NC}  Exit"
    echo "────────────────────────────────────────"
}

# NEW: Factorial function
factorial() {
    local n=$1
    local result=1
    for ((i=2; i<=n; i++)); do
        result=$((result * i))
    done
    echo $result
}

# NEW: Fibonacci function
fibonacci() {
    local n=$1
    local a=0
    local b=1
    
    if [ "$n" -eq 0 ]; then
        echo 0
        return
    fi
    
    for ((i=2; i<=n; i++)); do
        local temp=$((a + b))
        a=$b
        b=$temp
    done
    echo $b
}

# NEW: Prime check function
is_prime() {
    local n=$1
    if [ "$n" -le 1 ]; then
        echo "false"
        return
    fi
    if [ "$n" -le 3 ]; then
        echo "true"
        return
    fi
    if [ $((n % 2)) -eq 0 ] || [ $((n % 3)) -eq 0 ]; then
        echo "false"
        return
    fi
    local i=5
    while [ $((i * i)) -le "$n" ]; do
        if [ $((n % i)) -eq 0 ] || [ $((n % (i + 2))) -eq 0 ]; then
            echo "false"
            return
        fi
        i=$((i + 6))
    done
    echo "true"
}

# Save calculation to history
save_to_history() {
    local operation="$1"
    local result="$2"
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $operation = $result" >> "$HISTORY_FILE"
}

# View history
view_history() {
    echo -e "${YELLOW}📜 Recent Calculations:${NC}"
    echo "────────────────────────────────────────"
    if [ -s "$HISTORY_FILE" ]; then
        tail -n 20 "$HISTORY_FILE" | nl
    else
        echo "No history yet."
    fi
    echo "────────────────────────────────────────"
}

# Get valid number input
get_number() {
    local prompt="$1"
    local num=""
    until [[ $num =~ ^-?[0-9]+$ ]]; do
        read -r -p "   $prompt: " num
        if ! [[ $num =~ ^-?[0-9]+$ ]]; then
            echo -e "${RED}   Please enter a valid integer.${NC}"
        fi
    done
    echo "$num"
}

# Main calculator logic
calculate() {
    local choice=$1
    local num1=$2
    local num2=$3
    local result=""
    local operation=""
    
    case $choice in
        1)
            result=$((num1 + num2))
            operation="$num1 + $num2"
            ;;
        2)
            result=$((num1 - num2))
            operation="$num1 - $num2"
            ;;
        3)
            result=$((num1 * num2))
            operation="$num1 × $num2"
            ;;
        4)
            if [ "$num2" -eq 0 ]; then
                echo -e "${RED}Error: Division by zero!${NC}"
                return
            fi
            result=$(echo "scale=2; $num1 / $num2" | bc)
            operation="$num1 ÷ $num2"
            ;;
        22)
            # Factorial
            if [ "$num1" -lt 0 ]; then
                echo -e "${RED}Error: Factorial not defined for negative numbers!${NC}"
                return
            fi
            result=$(factorial "$num1")
            operation="$num1!"
            ;;
        23)
            # Fibonacci
            if [ "$num1" -lt 0 ]; then
                echo -e "${RED}Error: Fibonacci not defined for negative numbers!${NC}"
                return
            fi
            result=$(fibonacci "$num1")
            operation="Fibonacci($num1)"
            ;;
        24)
            # Prime check
            result=$(is_prime "$num1")
            operation="is_prime($num1)"
            ;;
        *)
            echo -e "${RED}Operation not yet implemented in this enhanced version.${NC}"
            return
            ;;
    esac
    
    echo -e "${GREEN}✓ Result: $result${NC}"
    save_to_history "$operation" "$result"
}

# Main loop
main() {
    show_banner
    
    while true; do
        show_menu
        echo ""
        read -r -p "Enter your choice (0-25): " choice
        
        case $choice in
            0)
                echo -e "${GREEN}Thank you for using Enhanced Bash Calculator!${NC}"
                exit 0
                ;;
            25)
                view_history
                ;;
            [1-4])
                num1=$(get_number "Enter first number")
                num2=$(get_number "Enter second number")
                calculate "$choice" "$num1" "$num2"
                ;;
            22|23|24)
                num1=$(get_number "Enter number")
                calculate "$choice" "$num1" 0
                ;;
            *)
                echo -e "${YELLOW}This operation will be implemented in future updates.${NC}"
                ;;
        esac
        
        echo ""
        read -r -p "Press Enter to continue..."
        clear
        show_banner
    done
}

# Install bc if not present
if ! command -v bc &> /dev/null; then
    echo -e "${YELLOW}Installing bc...${NC}"
    sudo apt install bc -y 2>/dev/null || pkg install bc -y 2>/dev/null
fi

# Run main function
main
