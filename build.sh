set -e

cd lambdas
find . -name "*.pyc" -exec rm -rf {} \;
zip -r ../build/echo.zip ./echo.py ./requests
zip -r ../build/screenshot.zip ./screenshot.py
