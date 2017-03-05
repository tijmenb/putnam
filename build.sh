set -e

cd lambdas
find . -name "*.pyc" -exec rm -rf {} \;
zip -r ../lambdas_to_upload/kickoff_trigger.zip ./kickoff_trigger.py ./requests
zip -r ../lambdas_to_upload/take_screenshot.zip ./take_screenshot.py
