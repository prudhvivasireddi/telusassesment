# EC2 Instance Details Webpage Project

## Overview
This project aims to create a simple webpage that displays the current timestamp and the hostname of an EC2 instance. The webpage will be hosted on the EC2 instance itself and served on port 80.

## Components
1. **EC2 Instance**: An Amazon EC2 instance is launched to host the webpage. It runs a user data script to set up the webpage content and start a web server on port 80.

2. **Auto Scaling Group (ASG)**: An Auto Scaling Group is configured to automatically adjust the number of EC2 instances based on traffic load. This ensures high availability and fault tolerance.

3. **Load Balancer (LB)**: A Load Balancer is used to distribute incoming traffic across multiple EC2 instances. It helps improve the scalability and reliability of the application.

4. **CloudWatch Alarm**: A CloudWatch Alarm is set up to monitor the EC2 instance's CPU utilization. If the CPU utilization exceeds a certain threshold (e.g., 90%), the alarm triggers an action, such as scaling up the ASG.

5. **User Data Script**: A Bash script (`user_data.sh`) is used as the user data when launching the EC2 instance. This script generates the HTML content for the webpage and starts the web server.

6. **Web Server**: The EC2 instance runs a web server (e.g., `httpd` or `nginx`) to serve the webpage content on port 80.

7. **Webpage**: The webpage displays the current timestamp and hostname of the EC2 instance in a simple HTML format.

## Traffic Flow
1. The user accesses the webpage by visiting the Load Balancer's DNS name in a web browser.

2. The Load Balancer receives the incoming traffic and distributes it across the EC2 instances in the Auto Scaling Group.

3. The Load Balancer uses a health check to ensure that only healthy EC2 instances receive traffic.

4. The EC2 instances receive the traffic and serve the webpage content to the user.

## Auto Scaling
1. The CloudWatch Alarm monitors the CPU utilization of the EC2 instances in the Auto Scaling Group.

2. If the CPU utilization of any EC2 instance exceeds the specified threshold (e.g., 90%), the CloudWatch Alarm triggers an action.

3. The Auto Scaling Group scales up by launching additional EC2 instances to handle the increased traffic.

4. The new EC2 instances are launched with the same user data script and configuration as the original EC2 instances.

5. The Load Balancer automatically detects the new EC2 instances and starts distributing traffic to them.

6. The Auto Scaling Group scales down (if necessary) based on the configured scaling policies and rules.

## Getting Started
1. Launch an Auto Scaling Group with a Load Balancer configured to distribute traffic.
2. Set up CloudWatch Alarms to monitor the performance of the EC2 instances.
3. Access the webpage by visiting the Load Balancer's DNS name in a web browser.

## Installation
No installation is required. Simply follow the steps in the "Getting Started" section to set up the Auto Scaling Group, Load Balancer, and CloudWatch Alarms.

## Usage
- Access the webpage by visiting the Load Balancer's DNS name in a web browser.
- The webpage will display the current timestamp and hostname of the EC2 instance.

## Credits
This project was created for an assessment and showcases the ability to set up a scalable and reliable webpage on AWS using Auto Scaling Group, Load Balancer, and CloudWatch Alarms.

## License
This project is open source and available under the MIT License.

Feel free to customize this README file to include any additional information specific to your project.