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
                            pip install --upgrade pip --timeout=60
                            pip install -r requirements.txt --timeout=60
                        '''
                    } else {
                        bat '''
                            python -m venv %VENV_NAME%
                            call %VENV_NAME%\\Scripts\\activate
                            pip install --upgrade pip --timeout=60
                            pip install -r requirements.txt --timeout=60
                        '''
                    }
                }
                echo '✅ Python environment setup completed'
            }
        }
        
        stage('Run Tests') {
            steps {
                echo '🧪 Running unit tests...'
                script {
                    if (isUnix()) {
                        sh '''
                            . ${VENV_NAME}/bin/activate
                            
                            # Run tests with unittest (simple approach)
                            python -m unittest test_app.py -v
                        '''
                    } else {
                        bat '''
                            call %VENV_NAME%\\Scripts\\activate
                            
                            REM Run tests with unittest
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
        }
        
        success {
            echo '✅ Pipeline completed successfully!'
            echo "🎉 Build ${BUILD_NUMBER} passed all stages"
        }
        
        failure {
            echo '❌ Pipeline failed!'
            echo "💥 Build ${BUILD_NUMBER} failed - please check the logs"
        }
        
        unstable {
            echo '⚠️ Pipeline completed but with warnings'
            echo "🔧 Build ${BUILD_NUMBER} has some issues that need attention"
        }
    }
}
