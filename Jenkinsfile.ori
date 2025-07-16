pipeline {
    agent any
    
    environment {
        PYTHON_VERSION = '3.9'
        VENV_NAME = 'venv'
        PROJECT_NAME = 'python-calculator'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo '🔄 Checking out code from repository...'
                checkout scm
                echo '✅ Code checkout completed'
            }
        }
        
        stage('Setup Python Environment') {
            steps {
                echo '🐍 Setting up Python virtual environment...'
                script {
                    if (isUnix()) {
                        sh '''
                            python3 -m venv ${VENV_NAME}
                            . ${VENV_NAME}/bin/activate
                            pip install --upgrade pip
                            pip install -r requirements.txt
                        '''
                    } else {
                        bat '''
                            python -m venv %VENV_NAME%
                            call %VENV_NAME%\\Scripts\\activate
                            pip install --upgrade pip
                            pip install -r requirements.txt
                        '''
                    }
                }
                echo '✅ Python environment setup completed'
            }
        }
        
        stage('Code Quality Check') {
            parallel {
                stage('Format Check') {
                    steps {
                        echo '🎨 Running code formatting checks...'
                        script {
                            if (isUnix()) {
                                sh '''
                                    . ${VENV_NAME}/bin/activate
                                    black --check --diff app.py test_app.py || echo "❌ Code formatting issues found"
                                    isort --check-only --diff app.py test_app.py || echo "❌ Import sorting issues found"
                                '''
                            } else {
                                bat '''
                                    call %VENV_NAME%\\Scripts\\activate
                                    black --check --diff app.py test_app.py || echo "❌ Code formatting issues found"
                                    isort --check-only --diff app.py test_app.py || echo "❌ Import sorting issues found"
                                '''
                            }
                        }
                    }
                }
                
                stage('Style Check') {
                    steps {
                        echo '📏 Running code style checks...'
                        script {
                            if (isUnix()) {
                                sh '''
                                    . ${VENV_NAME}/bin/activate
                                    flake8 app.py test_app.py --max-line-length=88 --exclude=${VENV_NAME} || echo "❌ Style issues found"
                                '''
                            } else {
                                bat '''
                                    call %VENV_NAME%\\Scripts\\activate
                                    flake8 app.py test_app.py --max-line-length=88 --exclude=%VENV_NAME% || echo "❌ Style issues found"
                                '''
                            }
                        }
                    }
                }
                
                stage('Security Check') {
                    steps {
                        echo '🔒 Running security checks...'
                        script {
                            if (isUnix()) {
                                sh '''
                                    . ${VENV_NAME}/bin/activate
                                    bandit -r app.py || echo "⚠️ Security issues found"
                                '''
                            } else {
                                bat '''
                                    call %VENV_NAME%\\Scripts\\activate
                                    bandit -r app.py || echo "⚠️ Security issues found"
                                '''
                            }
                        }
                    }
                }
            }
        }
        
        stage('Run Tests') {
            steps {
                echo '🧪 Running unit tests with coverage...'
                script {
                    if (isUnix()) {
                        sh '''
                            . ${VENV_NAME}/bin/activate
                            
                            # Run tests with pytest
                            python -m pytest test_app.py -v --cov=app --cov-report=xml --cov-report=html --cov-report=term-missing
                            
                            # Also run with unittest for compatibility
                            echo "\\n🔄 Running unittest for compatibility..."
                            python -m unittest test_app.py -v
                        '''
                    } else {
                        bat '''
                            call %VENV_NAME%\\Scripts\\activate
                            
                            REM Run tests with pytest
                            python -m pytest test_app.py -v --cov=app --cov-report=xml --cov-report=html --cov-report=term-missing
                            
                            REM Also run with unittest for compatibility
                            echo.
                            echo 🔄 Running unittest for compatibility...
                            python -m unittest test_app.py -v
                        '''
                    }
                }
                echo '✅ All tests completed'
            }
        }
        
        stage('Run Application') {
            steps {
                echo '🚀 Testing application execution...'
                script {
                    if (isUnix()) {
                        sh '''
                            . ${VENV_NAME}/bin/activate
                            echo "Testing application functionality..."
                            python app.py
                        '''
                    } else {
                        bat '''
                            call %VENV_NAME%\\Scripts\\activate
                            echo Testing application functionality...
                            python app.py
                        '''
                    }
                }
                echo '✅ Application test completed'
            }
        }
        
        stage('Build Artifact') {
            steps {
                echo '📦 Creating deployment artifact...'
                script {
                    if (isUnix()) {
                        sh '''
                            # Create distribution directory
                            mkdir -p dist
                            
                            # Copy application files
                            cp app.py dist/
                            cp requirements.txt dist/
                            
                            # Create version and build info
                            echo "Build Number: ${BUILD_NUMBER}" > dist/build-info.txt
                            echo "Build Date: $(date)" >> dist/build-info.txt
                            echo "Git Commit: ${GIT_COMMIT:-'N/A'}" >> dist/build-info.txt
                            echo "Jenkins Job: ${JOB_NAME}" >> dist/build-info.txt
                            
                            # Create deployment tarball
                            tar -czf dist/${PROJECT_NAME}-${BUILD_NUMBER}.tar.gz -C dist app.py requirements.txt build-info.txt
                            
                            # List created files
                            ls -la dist/
                        '''
                    } else {
                        bat '''
                            REM Create distribution directory
                            if not exist dist mkdir dist
                            
                            REM Copy application files
                            copy app.py dist\\
                            copy requirements.txt dist\\
                            
                            REM Create version and build info
                            echo Build Number: %BUILD_NUMBER% > dist\\build-info.txt
                            echo Build Date: %DATE% %TIME% >> dist\\build-info.txt
                            echo Git Commit: %GIT_COMMIT% >> dist\\build-info.txt
                            echo Jenkins Job: %JOB_NAME% >> dist\\build-info.txt
                            
                            REM List created files
                            dir dist
                        '''
                    }
                }
                echo '✅ Artifact creation completed'
            }
        }
    }
    
    post {
        always {
            echo '🧹 Cleaning up workspace...'
            script {
                if (isUnix()) {
                    sh 'rm -rf ${VENV_NAME} || true'
                } else {
                    bat 'if exist %VENV_NAME% rmdir /s /q %VENV_NAME% 2>nul || echo "Cleanup completed"'
                }
            }
            
            // Archive build artifacts
            archiveArtifacts artifacts: 'dist/*', fingerprint: true, allowEmptyArchive: true
            
            // Publish test results if available
            script {
                try {
                    publishTestResults testResultsPattern: '*.xml'
                } catch (Exception e) {
                    echo "No test XML results found"
                }
            }
            
            // Publish HTML coverage report if available
            script {
                try {
                    publishHTML([
                        allowMissing: false,
                        alwaysLinkToLastBuild: true,
                        keepAll: true,
                        reportDir: 'htmlcov',
                        reportFiles: 'index.html',
                        reportName: 'Coverage Report',
                        reportTitles: 'Code Coverage'
                    ])
                } catch (Exception e) {
                    echo "No coverage report found"
                }
            }
        }
        
        success {
            echo '✅ Pipeline completed successfully!'
            echo '🎉 Build ${BUILD_NUMBER} passed all stages'
            // ที่นี่สามารถเพิ่มการส่งการแจ้งเตือนไป Slack หรือ Email
        }
        
        failure {
            echo '❌ Pipeline failed!'
            echo '💥 Build ${BUILD_NUMBER} failed - please check the logs'
            // ส่งการแจ้งเตือนเมื่อ build ล้มเหลว
        }
        
        unstable {
            echo '⚠️ Pipeline completed but with warnings'
            echo '🔧 Build ${BUILD_NUMBER} has some issues that need attention'
        }
    }
}
