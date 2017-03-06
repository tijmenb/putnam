# Builds the lambdas into /dist
set -e

find . -name "*.pyc" -exec rm -rf {} \;

cd kickoff_trigger
zip -r ../dist/kickoff_trigger.zip .

cd -

cd take_screenshot
zip -r ../dist/take_screenshot.zip .
