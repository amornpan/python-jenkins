#!/usr/bin/env python3
"""
Unit tests for Calculator app
ทดสอบฟังก์ชันต่างๆ ของ Calculator
"""

import unittest
from app import Calculator

class TestCalculator(unittest.TestCase):
    
    def setUp(self):
        """ตั้งค่าเริ่มต้นสำหรับการทดสอบ"""
        self.calc = Calculator()
    
    def test_add(self):
        """ทดสอบการบวก"""
        self.assertEqual(self.calc.add(5, 3), 8)
        self.assertEqual(self.calc.add(-1, 1), 0)
        self.assertEqual(self.calc.add(0, 0), 0)
        self.assertEqual(self.calc.add(2.5, 1.5), 4.0)
    
    def test_subtract(self):
        """ทดสอบการลบ"""
        self.assertEqual(self.calc.subtract(10, 4), 6)
        self.assertEqual(self.calc.subtract(5, 5), 0)
        self.assertEqual(self.calc.subtract(0, 3), -3)
        self.assertEqual(self.calc.subtract(7.5, 2.5), 5.0)
    
    def test_multiply(self):
        """ทดสอบการคูณ"""
        self.assertEqual(self.calc.multiply(6, 7), 42)
        self.assertEqual(self.calc.multiply(5, 0), 0)
        self.assertEqual(self.calc.multiply(-2, 3), -6)
        self.assertEqual(self.calc.multiply(2.5, 4), 10.0)
    
    def test_divide(self):
        """ทดสอบการหาร"""
        self.assertEqual(self.calc.divide(15, 3), 5)
        self.assertEqual(self.calc.divide(10, 2), 5)
        self.assertEqual(self.calc.divide(7, 2), 3.5)
        
    def test_divide_by_zero(self):
        """ทดสอบการหารด้วยศูนย์ (ต้อง error)"""
        with self.assertRaises(ValueError):
            self.calc.divide(10, 0)
            
    def test_power(self):
        """ทดสอบการยกกำลัง"""
        self.assertEqual(self.calc.power(2, 3), 8)
        self.assertEqual(self.calc.power(5, 2), 25)
        self.assertEqual(self.calc.power(10, 0), 1)
        self.assertEqual(self.calc.power(3, 1), 3)
        
    def test_sqrt(self):
        """ทดสอบการหารากที่สอง"""
        self.assertEqual(self.calc.sqrt(16), 4)
        self.assertEqual(self.calc.sqrt(25), 5)
        self.assertEqual(self.calc.sqrt(0), 0)
        self.assertEqual(self.calc.sqrt(1), 1)
        
    def test_sqrt_negative(self):
        """ทดสอบรากที่สองของจำนวนลบ (ต้อง error)"""
        with self.assertRaises(ValueError):
            self.calc.sqrt(-1)

if __name__ == "__main__":
    # เรียกใช้ tests
    unittest.main(verbosity=2)
