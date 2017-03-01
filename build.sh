set -e

cd lambdas
find . -name "*.pyc" -exec rm -rf {} \;
zip -r ../build/kickoff_trigger.zip ./kickoff_trigger.py ./requests
zip -r ../build/take_screenshot.zip ./take_screenshot.py
