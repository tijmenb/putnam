import boto3
import requests
import json

# Kickoff Trigger
#
# Receives a notification from the thing that deploys, fetches URLs from
# search and schedules jobs for all of them.
def lambda_handler(event, context):
    response = requests.get('https://www.gov.uk/api/search.json?facet_content_store_document_type=250,examples:1,example_scope:global&count=0').json()

    paths = []

    for ex in response['facets']['content_store_document_type']['options']:
        paths.append(ex['value']['example_info']['examples'][0]['link'])

    sqs = boto3.resource('sqs')
    queue = sqs.get_queue_by_name(QueueName='screenshots-queue')

    for link in paths:
        queue.send_message(
            MessageBody=json.dumps({ 'link': link })
        )

    return { 'message': 'Queued messages', 'paths': paths }
