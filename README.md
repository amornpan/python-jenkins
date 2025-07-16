# 🚀 Python Calculator + Jenkins CI/CD Pipeline

โปรเจค Python Calculator พร้อมระบบ Jenkins CI/CD Pipeline สำหรับการทำ Automated Testing และ Deployment

## 📋 สารบัญ

1. [คำอธิบายโปรเจค](#คำอธิบายโปรเจค)
2. [โครงสร้างไฟล์](#โครงสร้างไฟล์)
3. [ความต้องการของระบบ](#ความต้องการของระบบ)
4. [การติดตั้งและตั้งค่า](#การติดตั้งและตั้งค่า)
5. [วิธีใช้งาน](#วิธีใช้งาน)
6. [การทดสอบ](#การทดสอบ)
7. [Jenkins Pipeline](#jenkins-pipeline)
8. [ขั้นตอนการทำงานทั้งหมด](#ขั้นตอนการทำงานทั้งหมด)
9. [การแก้ไขปัญหา](#การแก้ไขปัญหา)
10. [การพัฒนาต่อยอด](#การพัฒนาต่อยอด)

## 🎯 คำอธิบายโปรเจค

### ฟีเจอร์หลัก
- **Calculator App**: แอปพลิเคชันคำนวณเลขพื้นฐาน
- **Unit Testing**: ทดสอบอัตโนมัติครบทุกฟังก์ชัน
- **Jenkins CI/CD**: ระบบ build และ deploy อัตโนมัติ
- **GitHub Integration**: เชื่อมต่อกับ Git repository
- **Docker Support**: รัน Jenkins ด้วย Docker

### ฟังก์ชันคำนวณ
- ➕ **บวก** (Addition)
- ➖ **ลบ** (Subtraction)
- ✖️ **คูณ** (Multiplication)
- ➗ **หาร** (Division)
- 🔢 **ยกกำลัง** (Power)
- √ **รากที่สอง** (Square Root)

## 📁 โครงสร้างไฟล์

```
python-jenkins/
├── app.py                  # แอปพลิเคชันหลัก
├── test_app.py            # Unit tests
├── requirements.txt       # Python dependencies
├── Jenkinsfile           # Jenkins Pipeline configuration
├── README.md             # เอกสารนี้
├── .gitignore           # ไฟล์ที่ไม่ต้องการใน Git
├── run_local.sh         # สคริปต์สำหรับ Linux/Mac
└── run_local.bat        # สคริปต์สำหรับ Windows
```

## 🔧 ความต้องการของระบบ

### สำหรับการพัฒนา Local
- **Python**: 3.8 หรือใหม่กว่า
- **pip**: Python package manager
- **Git**: Version control system

### สำหรับ Jenkins CI/CD
- **Docker**: สำหรับรัน Jenkins container
- **GitHub Account**: สำหรับเก็บ source code
- **Jenkins**: รันผ่าน Docker

## 🛠️ การติดตั้งและตั้งค่า

### ขั้นตอนที่ 1: ติดตั้ง Docker

#### Windows
1. ดาวน์โหลด Docker Desktop จาก https://www.docker.com/products/docker-desktop
2. ติดตั้งและรีสตาร์ทคอมพิวเตอร์
3. เปิด Docker Desktop และรอให้เริ่มต้น

#### Linux/Mac
```bash
# Ubuntu/Debian
sudo apt update && sudo apt install docker.io

# CentOS/RHEL
sudo yum install docker

# macOS (ใช้ Homebrew)
brew install docker
```

### ขั้นตอนที่ 2: รัน Jenkins Container

```bash
# รัน Jenkins ด้วย Docker พร้อม timezone UTC+7
docker stop jenkins && docker rm jenkins && docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins-data:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -e TZ=Asia/Bangkok --restart=unless-stopped jenkins/jenkins:lts

# ตรวจสอบสถานะ
docker ps | grep jenkins

# ดูรหัสผ่านแอดมิน
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

### ขั้นตอนที่ 3: ตั้งค่า Jenkins เริ่มต้น

1. **เข้าถึง Jenkins**: เปิด browser ไปที่ `http://localhost:8080`

2. **Unlock Jenkins**:
   - Copy รหัสผ่านจากคำสั่งข้างต้น
   - Paste ในช่อง Administrator password
   - คลิก Continue

3. **ติดตั้ง Plugins**:
   - เลือก "Install suggested plugins"
   - รอการติดตั้ง (5-10 นาที)

4. **สร้างผู้ใช้แอดมิน**:
   ```
   Username: admin
   Password: [รหัสผ่านที่ต้องการ]
   Full name: Jenkins Administrator
   Email: your-email@example.com
   ```

5. **ตั้งค่า Jenkins URL**:
   - ปกติจะเป็น `http://localhost:8080`
   - คลิก "Save and Finish"

### ขั้นตอนที่ 4: ติดตั้ง Python ใน Jenkins Container

```bash
# เข้าไปใน Jenkins container
docker exec -it -u root jenkins bash

# อัพเดต package list
apt-get update

# ติดตั้ง Python3 และ tools
apt-get install -y python3 python3-pip python3-venv python3-dev

# ตรวจสอบการติดตั้ง
python3 --version
pip3 --version

# ออกจาก container
exit
```

### ขั้นตอนที่ 5: Clone โปรเจค

```bash
# Clone repository
git clone https://github.com/your-username/python-jenkins.git
cd python-jenkins

# สร้าง virtual environment
python3 -m venv venv

# เปิดใช้งาน virtual environment
# Windows:
venv\Scripts\activate
# Linux/Mac:
source venv/bin/activate

# ติดตั้ง dependencies
pip install -r requirements.txt
```

## 🚀 วิธีใช้งาน

### การรันแอปพลิเคชัน

```bash
# เปิดใช้งาน virtual environment
source venv/bin/activate  # Linux/Mac
# หรือ
venv\Scripts\activate     # Windows

# รันแอปพลิเคชัน
python app.py
```

**ผลลัพธ์:**
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

### การรันสคริปต์อัตโนมัติ

#### Windows
```bash
# รันสคริปต์ Windows
run_local.bat
```

#### Linux/Mac
```bash
# ทำให้ไฟล์สามารถรันได้
chmod +x run_local.sh

# รันสคริปต์
./run_local.sh
```

## 🧪 การทดสอบ

### Unit Tests

```bash
# รัน tests ด้วย unittest
python -m unittest test_app.py -v

# รัน tests พร้อม pytest (ถ้าติดตั้งไว้)
python -m pytest test_app.py -v
```

**ผลลัพธ์การทดสอบ:**
```
test_add (test_app.TestCalculator.test_add)
ทดสอบการบวก ... ok
test_divide (test_app.TestCalculator.test_divide)
ทดสอบการหาร ... ok
test_divide_by_zero (test_app.TestCalculator.test_divide_by_zero)
ทดสอบการหารด้วยศูนย์ (ต้อง error) ... ok
test_multiply (test_app.TestCalculator.test_multiply)
ทดสอบการคูณ ... ok
test_power (test_app.TestCalculator.test_power)
ทดสอบการยกกำลัง ... ok
test_sqrt (test_app.TestCalculator.test_sqrt)
ทดสอบการหารากที่สอง ... ok
test_sqrt_negative (test_app.TestCalculator.test_sqrt_negative)
ทดสอบรากที่สองของจำนวนลบ (ต้อง error) ... ok
test_subtract (test_app.TestCalculator.test_subtract)
ทดสอบการลบ ... ok

----------------------------------------------------------------------
Ran 8 tests in 0.000s
OK
```

### Test Coverage

```bash
# รัน tests พร้อม coverage (ถ้าติดตั้งไว้)
python -m pytest test_app.py --cov=app --cov-report=html
```

## 🔄 Jenkins Pipeline

### การสร้าง Pipeline Job

1. **เข้าสู่ Jenkins Dashboard**: `http://localhost:8080`

2. **สร้าง New Item**:
   - คลิก "New Item"
   - ตั้งชื่อ: `python-calculator-pipeline`
   - เลือก "Pipeline"
   - คลิก "OK"

3. **ตั้งค่า Pipeline**:
   
   #### General Settings
   - **Description**: `Python Calculator CI/CD Pipeline`
   - **GitHub project**: ✅ เลือก
   - **Project url**: `https://github.com/your-username/python-jenkins/`

   #### Build Triggers
   - **Poll SCM**: ✅ เลือก
   - **Schedule**: `H/5 * * * *` (ตรวจสอบทุก 5 นาที)

   #### Pipeline Configuration
   - **Definition**: `Pipeline script from SCM`
   - **SCM**: `Git`
   - **Repository URL**: `https://github.com/your-username/python-jenkins.git`
   - **Branch Specifier**: `*/master`
   - **Script Path**: `Jenkinsfile`

4. **บันทึกการตั้งค่า**: คลิก "Save"

### การรัน Pipeline

1. **Manual Build**:
   - คลิก "Build Now"
   - ดูสถานะใน "Build History"

2. **Automatic Build**:
   - Jenkins จะ detect การเปลี่ยนแปลงใน GitHub อัตโนมัติ
   - Build ใหม่จะเกิดขึ้นเมื่อมีการ push code

### Pipeline Stages

```
📋 Pipeline Stages:
┌─────────────────────────────────────────────────────────────────┐
│ 1. Checkout        │ ดึงโค้ดจาก GitHub                          │
│ 2. Setup Python    │ ติดตั้ง virtual environment และ packages │
│ 3. Run Tests       │ รัน unit tests                            │
│ 4. Run Application │ ทดสอบการรันแอปพลิเคชัน                     │
│ 5. Build Artifact  │ สร้างไฟล์ deployment                      │
│ 6. Post Actions    │ ทำความสะอาดและเก็บ artifacts              │
└─────────────────────────────────────────────────────────────────┘
```

### การดูผลลัพธ์

1. **Stage View**: ดูสถานะของแต่ละ stage
2. **Console Output**: ดู logs แบบละเอียด
3. **Build Artifacts**: ดาวน์โหลดไฟล์ที่สร้าง
4. **Test Results**: ดูผลการทดสอบ

## 🎯 ขั้นตอนการทำงานทั้งหมด

### **📝 Phase 1: Developer Workflow**
```
Developer → Code → Test → Commit → Push → GitHub
    ↓         ↓      ↓       ↓        ↓       ↓
 เขียนโค้ด  ทดสอบ  แก้ไข  บันทึก   ส่งไป  รอ Jenkins
```

### **🌐 Phase 2: GitHub Integration**
```
GitHub Repository Update:
┌─────────────────────────────────────────┐
│ 📁 New Commit Detected                 │
│ ├── Commit Hash: abc123...             │
│ ├── Author: Developer                  │
│ ├── Message: "Add new feature"         │
│ └── Files Changed: app.py, test_app.py │
└─────────────────────────────────────────┘
```

### **🔍 Phase 3: Jenkins Detection**
```
Jenkins Scheduler:
┌─────────────────────────────────────────┐
│ 🕐 Poll SCM every 5 minutes            │
│ ├── 09:00 - No changes                 │
│ ├── 09:05 - No changes                 │
│ ├── 09:10 - New commit found!          │
│ └── 09:10 - Trigger Build #9           │
└─────────────────────────────────────────┘
```

### **⚙️ Phase 4: Pipeline Execution**
```
Jenkins Pipeline Flow:
┌─────────────────────────────────────────────────────────────────┐
│ Stage 1: Checkout                                               │
│ └── ✅ Download code from GitHub (15s)                         │
│                                                                 │
│ Stage 2: Setup Python Environment                              │
│ └── ✅ Create venv + install packages (45s)                    │
│                                                                 │
│ Stage 3: Run Tests                                             │
│ └── ✅ Execute 8 unit tests (30s)                              │
│                                                                 │
│ Stage 4: Run Application                                       │
│ └── ✅ Test app functionality (10s)                            │
│                                                                 │
│ Stage 5: Build Artifact                                        │
│ └── ✅ Create deployment package (20s)                         │
│                                                                 │
│ Stage 6: Post Actions                                          │
│ └── ✅ Cleanup + Archive artifacts (10s)                       │
└─────────────────────────────────────────────────────────────────┘
```

### **📊 Phase 5: Results & Feedback**
```
Build Results:
┌─────────────────────────────────────────┐
│ 🎉 Build #9 - SUCCESS                  │
│ ├── Duration: 2m 30s                   │
│ ├── Tests: 8/8 passed                  │
│ ├── Artifacts: Created                 │
│ └── Status: Ready for deployment       │
└─────────────────────────────────────────┘
```

### **🔄 Continuous Integration Process**
```
Code Quality Assurance Flow:
┌─────────────────────────────────────────┐
│ Developer Push                          │
│         ↓                               │
│ Jenkins Build                           │
│         ↓                               │
│ Automated Tests                         │
│         ↓                               │
│ ✅ Pass → Deploy Ready                  │
│ ❌ Fail → Block + Alert                 │
└─────────────────────────────────────────┘
```

### **🚨 Build Scenarios**

#### **Scenario 1: Successful Build**
```
Timeline:
09:00:00 - Developer pushes code
09:05:00 - Jenkins detects change
09:05:01 - Build #9 starts
09:07:31 - Build completed ✅
09:07:32 - Notification sent
```

#### **Scenario 2: Failed Build**
```
Timeline:
10:00:00 - Developer pushes buggy code
10:05:00 - Jenkins detects change
10:05:01 - Build #10 starts
10:06:30 - Test failure detected ❌
10:06:31 - Build marked as FAILED
10:06:32 - Alert sent to developer
```

### **📈 Build Metrics**
```
Pipeline Performance:
┌─────────────────────────────────────────┐
│ Stage           │ Avg Time │ Success    │
│ Checkout        │ 15s      │ 100%       │
│ Setup Python    │ 45s      │ 98%        │
│ Run Tests       │ 30s      │ 95%        │
│ Run Application │ 10s      │ 100%       │
│ Build Artifact  │ 20s      │ 100%       │
│ Total           │ 2m 30s   │ 95%        │
└─────────────────────────────────────────┘
```

### **🎯 Key Benefits**
- **Automation**: ทำงานอัตโนมัติ 100%
- **Quality Assurance**: ทดสอบทุกครั้งก่อน deploy
- **Fast Feedback**: รู้ผลลัพธ์ใน 2-3 นาที
- **Traceability**: ติดตามได้ทุกขั้นตอน
- **Scalability**: ขยายได้ตามต้องการ

## 🔧 การแก้ไขปัญหา

### ปัญหาที่พบบ่อย

#### 1. Python ไม่พบใน Jenkins
```bash
# แก้ไข: ติดตั้ง Python ใน Jenkins container
docker exec -it -u root jenkins bash
apt-get update && apt-get install -y python3 python3-pip python3-venv
```

#### 2. Permission Error
```bash
# แก้ไข: ตั้งค่า permission สำหรับ Docker
sudo chown root:docker /var/run/docker.sock
sudo chmod 666 /var/run/docker.sock
```

#### 3. Network Timeout
```bash
# แก้ไข: เพิ่ม timeout ใน pip
pip install --timeout=300 -r requirements.txt
```

#### 4. Git Repository ไม่พบ
- ตรวจสอบ Repository URL ใน Jenkins configuration
- ตรวจสอบว่า repository เป็น Public
- ตรวจสอบว่า Jenkinsfile อยู่ใน root directory

### การตรวจสอบ Logs

```bash
# ดู Jenkins logs
docker logs jenkins

# ดู Jenkins container status
docker ps | grep jenkins

# เข้าไปตรวจสอบใน container
docker exec -it jenkins bash
```

## 🎯 การพัฒนาต่อยอด

### 1. เพิ่มฟีเจอร์ใหม่

```python
# เพิ่มฟังก์ชันใหม่ใน app.py
def percentage(self, value, percent):
    """คำนวณเปอร์เซ็นต์"""
    return (value * percent) / 100

def factorial(self, n):
    """คำนวณแฟกทอเรียล"""
    if n < 0:
        raise ValueError("Cannot calculate factorial of negative number")
    if n == 0 or n == 1:
        return 1
    result = 1
    for i in range(2, n + 1):
        result *= i
    return result
```

### 2. เพิ่ม Code Quality Checks

```groovy
// เพิ่มใน Jenkinsfile
stage('Code Quality') {
    parallel {
        stage('Lint') {
            steps {
                sh '''
                    . venv/bin/activate
                    flake8 app.py test_app.py
                '''
            }
        }
        stage('Format') {
            steps {
                sh '''
                    . venv/bin/activate
                    black --check app.py test_app.py
                '''
            }
        }
    }
}
```

### 3. เพิ่ม Docker Support

```dockerfile
# Dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY app.py .

CMD ["python", "app.py"]
```

### 4. เพิ่ม Web Interface

```python
# app_web.py
from flask import Flask, render_template, request, jsonify
from app import Calculator

app = Flask(__name__)
calc = Calculator()

@app.route('/')
def index():
    return render_template('calculator.html')

@app.route('/calculate', methods=['POST'])
def calculate():
    data = request.json
    operation = data.get('operation')
    a = float(data.get('a', 0))
    b = float(data.get('b', 0))
    
    try:
        if operation == 'add':
            result = calc.add(a, b)
        elif operation == 'subtract':
            result = calc.subtract(a, b)
        elif operation == 'multiply':
            result = calc.multiply(a, b)
        elif operation == 'divide':
            result = calc.divide(a, b)
        elif operation == 'power':
            result = calc.power(a, b)
        elif operation == 'sqrt':
            result = calc.sqrt(a)
        else:
            return jsonify({'error': 'Invalid operation'}), 400
        
        return jsonify({'result': result})
    except Exception as e:
        return jsonify({'error': str(e)}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

### 5. เพิ่ม Database Support

```python
# database.py
import sqlite3
from datetime import datetime

class CalculationHistory:
    def __init__(self, db_path='calculations.db'):
        self.db_path = db_path
        self.init_db()
    
    def init_db(self):
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS calculations (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                operation TEXT NOT NULL,
                operand1 REAL NOT NULL,
                operand2 REAL,
                result REAL NOT NULL,
                timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        conn.commit()
        conn.close()
    
    def save_calculation(self, operation, operand1, operand2, result):
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        cursor.execute('''
            INSERT INTO calculations (operation, operand1, operand2, result)
            VALUES (?, ?, ?, ?)
        ''', (operation, operand1, operand2, result))
        conn.commit()
        conn.close()
```

### 6. เพิ่ม Monitoring และ Alerts

```yaml
# docker-compose.yml
version: '3.8'
services:
  jenkins:
    image: jenkins/jenkins:lts
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - jenkins-data:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
    restart: unless-stopped
    
  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
      
  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin

volumes:
  jenkins-data:
```

## 📞 การสนับสนุน

### หากพบปัญหา
1. ตรวจสอบ [การแก้ไขปัญหา](#การแก้ไขปัญหา) ด้านบน
2. ดู Console Output ใน Jenkins
3. ตรวจสอบ Docker logs
4. สร้าง Issue ใน GitHub repository

### การติดต่อ
- **GitHub**: https://github.com/your-username/python-jenkins
- **Email**: your-email@example.com

## 📄 License

โปรเจคนี้ใช้ MIT License - ดูรายละเอียดในไฟล์ [LICENSE](LICENSE)

## 🙏 ขอบคุณ

- [Jenkins](https://jenkins.io/) - Open Source CI/CD Platform
- [Docker](https://docker.com/) - Container Platform
- [Python](https://python.org/) - Programming Language
- [GitHub](https://github.com/) - Version Control Platform

---

## 🎓 สรุป

โปรเจคนี้แสดงให้เห็นการสร้าง CI/CD Pipeline ที่สมบูรณ์โดยใช้:
- **Python** สำหรับแอปพลิเคชัน
- **Jenkins** สำหรับ CI/CD
- **Docker** สำหรับ containerization
- **GitHub** สำหรับ version control
- **Unit Testing** สำหรับ quality assurance

เหมาะสำหรับการเรียนรู้ DevOps และการพัฒนาซอฟต์แวร์สมัยใหม่! 🚀

**Happy Coding! 🎉**
