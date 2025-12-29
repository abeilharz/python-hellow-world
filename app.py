from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def hello():
    # Fetch CodeDeploy environment variables with defaults
    deployment_id = os.getenv("AWS_DEPLOYMENT_ID", "N/A")
    app_name = os.getenv("AWS_APPLICATION_NAME", "N/A")
    deployment_group = os.getenv("AWS_DEPLOYMENT_GROUP_NAME", "N/A")
    deployment_group_id = os.getenv("AWS_DEPLOYMENT_GROUP_ID", "N/A")
    lifecycle_event = os.getenv("AWS_LIFECYCLE_EVENT", "N/A")
    instance_id = os.getenv("AWS_INSTANCE_ID", "N/A")
    region = os.getenv("AWS_REGION", "N/A")

    # Return simple HTML with centered content
    return f"""
    <html>
        <head>
            <title>Deployment Info</title>
            <style>
                body {{
                    font-family: Arial, sans-serif;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    background-color: #f4f4f4;
                }}
                .container {{
                    background: #fff;
                    padding: 20px 40px;
                    border-radius: 10px;
                    box-shadow: 0 0 10px rgba(0,0,0,0.1);
                    text-align: center;
                }}
                h1 {{
                    color: #333;
                }}
                p {{
                    margin: 5px 0;
                    color: #555;
                }}
            </style>
        </head>
        <body>
            <div class="container">
                <h1>Python Hello World ... Version 1.0!</h1>
                <p><strong>Application Name:</strong> {app_name}</p>
                <p><strong>Deployment Group ID:</strong> {deployment_group_id}</p>
                <p><strong>Deployment ID:</strong> {deployment_id}</p>
                <p><strong>Deployment Group:</strong> {deployment_group}</p>
                <p><strong>Lifecycle Event:</strong> {lifecycle_event}</p>
                <p><strong>EC2 Instance ID:</strong> {instance_id}</p>
                <p><strong>Region:</strong> {region}</p>
            </div>
        </body>
    </html>
    """

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

