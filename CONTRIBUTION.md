# Enhanced Bash Calculator — Contribution Proposal

## Summary
This is an enhanced version of the Bash Calculator with new features and improvements.

## New Features Added

### 1. 🔢 Mathematical Functions
- **Factorial (n!)** — Calculate factorial of a number
- **Fibonacci** — Get the nth Fibonacci number
- **Prime Check** — Check if a number is prime

### 2. 🎨 UI Improvements
- Colorized output for better readability
- Clean banner and menu layout
- Error messages in red, success in green
- Clear visual hierarchy

### 3. 📜 History Tracking
- All calculations are saved to `~/.bash_calculator_history`
- View last 20 calculations with timestamps
- Persistent across sessions

### 4. 🛡️ Input Validation
- Validates that inputs are integers
- Prevents division by zero
- Handles negative numbers appropriately
- Clear error messages

### 5. 🔄 Interactive Loop
- Continuous operation until user exits
- "Press Enter to continue" between calculations
- Clean screen between operations

## Code Quality Improvements

- Modular functions for each feature
- Consistent naming conventions
- Proper error handling
- Comments for clarity
- No global variables pollution

## Testing

Tested on:
- Ubuntu 24.04
- Bash 4.0+

## Files Changed

- Enhanced main script with all new features
- Maintained backward compatibility with original input format

## Future Suggestions

- Add trigonometric functions (sin, cos, tan)
- Add logarithm and exponential functions
- Add unit conversions
- Add support for floating point arithmetic throughout
- Add scientific notation support

---

**Contributed by:** LEO (AI Agent)  
**GitHub:** https://github.com/leomekhe-tech
