# Python Calculator App for Jenkins CI/CD

โปรเจค Python Calculator แบบง่ายสำหรับทดสอบ Jenkins CI/CD Pipeline

## 📁 โครงสร้างโปรเจค

```
python-jenkins/
├── app.py              # แอปพลิเคชันหลัก (Calculator)
├── test_app.py         # Unit tests
├── requirements.txt    # Python dependencies
├── Jenkinsfile        # Jenkins Pipeline configuration
└── README.md          # เอกสารนี้
```

## 🚀 วิธีรันโปรเจค

### รันแบบ Local

```bash
# สร้าง virtual environment
python -m venv venv

# เปิดใช้งาน virtual environment
# Windows:
venv\Scripts\activate
# Linux/Mac:
source venv/bin/activate

# ติดตั้ง dependencies
pip install -r requirements.txt

# รันแอปพลิเคชัน
python app.py

# รัน tests
python -m pytest test_app.py -v
# หรือ
python -m unittest test_app.py -v
```

### รันด้วย Coverage Report

```bash
# รัน tests พร้อม coverage
python -m pytest test_app.py -v --cov=app --cov-report=html --cov-report=term-missing

# ดู coverage report ใน browser
# เปิดไฟล์ htmlcov/index.html
```

## 🔧 Features

### Calculator Functions
- ➕ บวก (add)
- ➖ ลบ (subtract)  
- ✖️ คูณ (multiply)
- ➗ หาร (divide)
- 🔢 ยกกำลัง (power)
- √ รากที่สอง (sqrt)

### CI/CD Pipeline Stages
1. **Checkout** - ดึงโค้ดจาก repository
2. **Setup** - ติดตั้ง Python environment และ dependencies
3. **Code Quality** - ตรวจสอบ formatting, style, และ security
4. **Tests** - รัน unit tests พร้อม coverage report
5. **Run App** - ทดสอบการรันแอปพลิเคชัน
6. **Build** - สร้าง deployment artifacts

## 🔍 Code Quality Tools

- **Black** - Code formatting
- **isort** - Import sorting
- **flake8** - Style checking
- **bandit** - Security scanning
- **pytest** - Testing framework
- **coverage** - Code coverage analysis

## 📊 Jenkins Integration

### สร้าง Jenkins Job

1. **New Item** → **Pipeline**
2. **Pipeline Definition**: "Pipeline script from SCM"
3. **SCM**: Git
4. **Repository URL**: `path/to/your/repo`
5. **Script Path**: `Jenkinsfile`

### Pipeline Features

- ✅ Cross-platform support (Windows/Linux/Mac)
- ✅ Parallel execution สำหรับ code quality checks
- ✅ Comprehensive testing และ coverage reports
- ✅ Artifact archiving
- ✅ HTML reports publishing
- ✅ Error handling และ cleanup

## 📈 ตัวอย่าง Output

### การรันแอปพลิเคชัน
```
=== Python Calculator for Jenkins ===
Testing basic operations...
5 + 3 = 8
10 - 4 = 6
6 * 7 = 42
15 / 3 = 5.0
2 ^ 3 = 8
√16 = 4.0

All operations completed successfully!
```

### การรัน Tests
```
test_add (__main__.TestCalculator) ... ok
test_divide (__main__.TestCalculator) ... ok
test_divide_by_zero (__main__.TestCalculator) ... ok
test_multiply (__main__.TestCalculator) ... ok
test_power (__main__.TestCalculator) ... ok
test_sqrt (__main__.TestCalculator) ... ok
test_sqrt_negative (__main__.TestCalculator) ... ok
test_subtract (__main__.TestCalculator) ... ok

----------------------------------------------------------------------
Ran 8 tests in 0.001s

OK
```

## 🔄 การพัฒนาต่อยอด

### เพิ่ม Docker Support
```dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY app.py .
CMD ["python", "app.py"]
```

### เพิ่ม Web Interface
```python
from flask import Flask, render_template, request
app = Flask(__name__)

@app.route('/')
def calculator():
    return render_template('calculator.html')
```

### เพิ่ม Database Integration
```python
import sqlite3

def save_calculation(operation, result):
    conn = sqlite3.connect('calculations.db')
    # Save calculation to database
```

## 🛠️ Troubleshooting

### Common Issues

1. **Virtual Environment Issues**
   ```bash
   # ลบและสร้างใหม่
   rm -rf venv  # หรือ rmdir /s venv สำหรับ Windows
   python -m venv venv
   ```

2. **Dependencies Issues**
   ```bash
   pip install --upgrade pip
   pip install -r requirements.txt --force-reinstall
   ```

3. **Test Failures**
   ```bash
   # รัน tests แบบ verbose
   python -m pytest test_app.py -v -s
   ```

## 📝 หมายเหตุ

- โปรเจคนี้ออกแบบมาสำหรับการเรียนรู้ Jenkins CI/CD
- รองรับการรันทั้งบน Windows และ Linux
- มี comprehensive testing และ code quality checks
- พร้อมสำหรับการขยายและพัฒนาต่อไป

## 📞 การติดต่อ

หากมีคำถามหรือต้องการความช่วยเหลือ สามารถสร้าง issue ใน repository หรือติดต่อผู้พัฒนา

---
🎯 **Happy Coding with Jenkins!** 🎯
