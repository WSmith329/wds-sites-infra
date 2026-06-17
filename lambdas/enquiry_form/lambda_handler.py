import json
import os
import boto3

from string import Template

ses = boto3.client("ses")
s3 = boto3.client("s3")


def lambda_handler(event, context):
    body = json.loads(event["body"])

    name = body.get("name")
    email = body.get("email")

    if not all([name, email]):
        return {
            "statusCode": 400,
            "body": json.dumps({
                "message": "Missing required fields"
            })
        }

    resources_bucket = os.environ["RESOURCES_BUCKET"]
    enquiry_form_template_key = os.environ["ENQUIRY_FORM_TEMPLATE_KEY"]

    enquiry_form_template = s3.get_object(Bucket=resources_bucket, Key=enquiry_form_template_key)

    enquiry_form_html = Template(enquiry_form_template).safe_substitute(
        name=name,
        year="2026"
    )

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
                "Html": {
                    "Data": enquiry_form_html
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