#!/bin/bash
sudo dnf update -y
sudo dnf install -y nginx
hostname=$(hostname -f)
cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Telus Assesment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        h1 {
            color: #333;
        }

        .container {
            margin-top: 50px;
        }

        p {
            font-size: 18px;
            color: #555;
        }

        span {
            font-weight: bold;
            color: #007bff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Telus Assesment</h1>
        <p>Current Time: <span id="current-time"></span></p>
        <p>Hostname: <span>$hostname</span></p>
    </div>

    <script>
        // Get current time
        function getCurrentTime() {
            var currentTime = new Date();
            var hours = currentTime.getHours();
            var minutes = currentTime.getMinutes();
            var seconds = currentTime.getSeconds();
            var formattedTime = hours + ":" + minutes + ":" + seconds;
            document.getElementById("current-time").textContent = formattedTime;
        }

        setInterval(function() {
            getCurrentTime();
        }, 1000);
    </script>
</body>
</html>
EOF

sudo systemctl start nginx