import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    logger.info('received {}'.format(event))
    return {'hola': 'friends!'}
