import json


def index(event, context):
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Hello there! This works!')
    }
