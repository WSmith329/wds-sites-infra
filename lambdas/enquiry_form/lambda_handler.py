import json
import os
import boto3

from string import Template

ses = boto3.client("ses")
s3 = boto3.client("s3")

def _get_email_html(template_key: str, substitutions: dict) -> str:
    resources_bucket = os.environ["RESOURCES_BUCKET"]
    template_content = s3.get_object(Bucket=resources_bucket, Key=template_key)["Body"].read().decode("utf-8")
    return Template(template_content).safe_substitute(**substitutions)


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

    enquiry_form_html = _get_email_html(os.environ["ENQUIRY_FORM_TEMPLATE_KEY"], body)
    enquiry_receipt_html = _get_email_html(os.environ["ENQUIRY_RECEIPT_TEMPLATE_KEY"], {"name": name})

    owner_email = os.environ["OWNER_EMAIL"]
    from_email = os.environ["FROM_EMAIL"]
    if from_display_name := os.environ.get("FROM_DISPLAY_NAME"):
        from_email = f"{from_display_name} <{from_email}>"

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
                "Html": {
                    "Data": enquiry_receipt_html
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