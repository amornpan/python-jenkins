#!/usr/bin/env python3
"""
Simple Python Calculator App
สำหรับทดสอบ Jenkins CI/CD Pipeline
"""

class Calculator:
    def add(self, a, b):
        """บวก"""
        return a + b
    
    def subtract(self, a, b):
        """ลบ"""
        return a - b
    
    def multiply(self, a, b):
        """คูณ"""
        return a * b
    
    def divide(self, a, b):
        """หาร"""
        if b == 0:
            raise ValueError("Cannot divide by zero")
        return a / b
    
    def power(self, a, b):
        """ยกกำลัง"""
        return a ** b
    
    def sqrt(self, a):
        """รากที่สอง"""
        if a < 0:
            raise ValueError("Cannot calculate square root of negative number")
        return a ** 0.5

def main():
    calc = Calculator()
    
    print("=== Python Calculator for Jenkins ===")
    print("Testing basic operations...")
    
    try:
        print(f"5 + 4 = {calc.add(5, 4)}")
        print(f"10 - 4 = {calc.subtract(10, 4)}")
        print(f"6 * 7 = {calc.multiply(6, 7)}")
        print(f"15 / 3 = {calc.divide(15, 3)}")
        print(f"2 ^ 3 = {calc.power(2, 3)}")
        print(f"√16 = {calc.sqrt(16)}")
        
        print("\nAll operations completed successfully!")
        return 0
        
    except Exception as e:
        print(f"Error: {e}")
        return 1

if __name__ == "__main__":
    exit_code = main()
    exit(exit_code)
