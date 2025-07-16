@echo off
REM สคริปต์สำหรับรัน Local Development และ Testing บน Windows
REM รันด้วย: run_local.bat

echo 🚀 Starting Python Jenkins Project Local Development
echo =================================================

REM ตรวจสอบว่ามี Python หรือไม่
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python is not installed. Please install Python first.
    pause
    exit /b 1
)

echo ✅ Python found
python --version

REM สร้าง virtual environment ถ้ายังไม่มี
if not exist "venv" (
    echo 📦 Creating virtual environment...
    python -m venv venv
    echo ✅ Virtual environment created
) else (
    echo ✅ Virtual environment already exists
)

REM เปิดใช้งาน virtual environment
echo 🔄 Activating virtual environment...
call venv\Scripts\activate

REM อัพเกรด pip
echo ⬆️ Upgrading pip...
pip install --upgrade pip

REM ติดตั้ง dependencies
echo 📥 Installing dependencies...
pip install -r requirements.txt

echo.
echo 🧪 Running Tests...
echo ==================

REM รัน tests พร้อม coverage
python -m pytest test_app.py -v --cov=app --cov-report=html --cov-report=term-missing

echo.
echo 🚀 Running Application...
echo ========================

REM รันแอปพลิเคชัน
python app.py

echo.
echo 🎨 Running Code Quality Checks...
echo =================================

REM ตรวจสอบ code formatting
echo 📏 Checking code formatting...
black --check --diff app.py test_app.py || echo ⚠️ Run 'black app.py test_app.py' to fix formatting

REM ตรวจสอบ import sorting
echo 📋 Checking import sorting...
isort --check-only --diff app.py test_app.py || echo ⚠️ Run 'isort app.py test_app.py' to fix imports

REM ตรวจสอบ code style
echo 📐 Checking code style...
flake8 app.py test_app.py --max-line-length=88 --exclude=venv || echo ⚠️ Style issues found

REM ตรวจสอบ security
echo 🔒 Running security check...
bandit -r app.py || echo ⚠️ Security issues found

echo.
echo ✅ Local development setup completed!
echo 📊 Coverage report available at: htmlcov\index.html
echo 🔍 To view coverage report: open htmlcov\index.html in your browser
echo.
echo 🛠️ Useful commands:
echo   - Run tests: python -m pytest test_app.py -v
echo   - Run app: python app.py
echo   - Format code: black app.py test_app.py
echo   - Sort imports: isort app.py test_app.py
echo   - Check style: flake8 app.py test_app.py --max-line-length=88
echo.
echo 🎯 Ready for Jenkins CI/CD!
echo.

pause
