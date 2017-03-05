import boto3
import requests
import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Kickoff Trigger
#
# Receives a notification from the thing that deploys, fetches URLs from
# search and schedules jobs for all of them.
def lambda_handler(event, context):
    response = requests.get('https://www.gov.uk/api/search.json?facet_content_store_document_type=250,examples:1,example_scope:global&count=0').json()

    paths = []

    for ex in response['facets']['content_store_document_type']['options']:
        paths.append(ex['value']['example_info']['examples'][0]['link'])

    client = boto3.client('sns')

    for path in paths:
        response = client.publish(
            TargetArn='arn:aws:sns:eu-west-1:886111561883:invoke-screenshot-topic',
            Message=json.dumps({'default': json.dumps({ 'path': path })}),
            MessageStructure='json'
        )
        logger.info('response ' + path + ': {}'.format(response))

    return { 'message': 'Queued messages', 'paths': paths }
