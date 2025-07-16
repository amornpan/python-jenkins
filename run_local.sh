#!/bin/bash

# สคริปต์สำหรับรัน Local Development และ Testing
# รันด้วย: ./run_local.sh หรือ bash run_local.sh

echo "🚀 Starting Python Jenkins Project Local Development"
echo "================================================="

# ตรวจสอบว่ามี Python หรือไม่
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 is not installed. Please install Python3 first."
    exit 1
fi

echo "✅ Python3 found: $(python3 --version)"

# สร้าง virtual environment ถ้ายังไม่มี
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
    echo "✅ Virtual environment created"
else
    echo "✅ Virtual environment already exists"
fi

# เปิดใช้งาน virtual environment
echo "🔄 Activating virtual environment..."
source venv/bin/activate

# อัพเกรด pip
echo "⬆️ Upgrading pip..."
pip install --upgrade pip

# ติดตั้ง dependencies
echo "📥 Installing dependencies..."
pip install -r requirements.txt

echo ""
echo "🧪 Running Tests..."
echo "=================="

# รัน tests พร้อม coverage
python -m pytest test_app.py -v --cov=app --cov-report=html --cov-report=term-missing

echo ""
echo "🚀 Running Application..."
echo "========================"

# รันแอปพลิเคชัน
python app.py

echo ""
echo "🎨 Running Code Quality Checks..."
echo "================================="

# ตรวจสอบ code formatting
echo "📏 Checking code formatting..."
black --check --diff app.py test_app.py || echo "⚠️ Run 'black app.py test_app.py' to fix formatting"

# ตรวจสอบ import sorting
echo "📋 Checking import sorting..."
isort --check-only --diff app.py test_app.py || echo "⚠️ Run 'isort app.py test_app.py' to fix imports"

# ตรวจสอบ code style
echo "📐 Checking code style..."
flake8 app.py test_app.py --max-line-length=88 --exclude=venv || echo "⚠️ Style issues found"

# ตรวจสอบ security
echo "🔒 Running security check..."
bandit -r app.py || echo "⚠️ Security issues found"

echo ""
echo "✅ Local development setup completed!"
echo "📊 Coverage report available at: htmlcov/index.html"
echo "🔍 To view coverage report: open htmlcov/index.html in your browser"
echo ""
echo "🛠️ Useful commands:"
echo "  - Run tests: python -m pytest test_app.py -v"
echo "  - Run app: python app.py"
echo "  - Format code: black app.py test_app.py"
echo "  - Sort imports: isort app.py test_app.py"
echo "  - Check style: flake8 app.py test_app.py --max-line-length=88"
echo ""
echo "🎯 Ready for Jenkins CI/CD!"
