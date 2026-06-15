import json
import os
import boto3

ses = boto3.client("ses")


def lambda_handler(event, context):
    body = json.loads(event["body"])

    name = body.get("name")
    email = body.get("email")
    message = body.get("message")

    if not all([name, email, message]):
        return {
            "statusCode": 400,
            "body": json.dumps({
                "message": "Missing required fields"
            })
        }

    owner_email = os.environ["OWNER_EMAIL"]
    from_email = os.environ["FROM_EMAIL"]

    ses.send_email(
        Source=from_email,
        Destination={
            "ToAddresses": [owner_email]
        },
        Message={
            "Subject": {
                "Data": f"New enquiry from {name}"
            },
            "Body": {
                "Text": {
                    "Data": f"""
Name: {name}
Email: {email}

{message}
"""
                }
            }
        }
    )

    ses.send_email(
        Source=from_email,
        Destination={
            "ToAddresses": [email]
        },
        Message={
            "Subject": {
                "Data": "We've received your enquiry"
            },
            "Body": {
                "Text": {
                    "Data": (
                        "Thank you for getting in touch. "
                        "We'll respond as soon as possible."
                    )
                }
            }
        }
    )

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Enquiry received"
        })
    }