# Server Health Check

A lightweight Linux server health monitoring script written in Bash.

The script checks essential system resources and network connectivity, detects requested applications, and provides a quick overview of a server's health directly from the terminal.

## Features

* CPU usage monitoring
* Memory usage monitoring
* Disk usage monitoring
* Health status classification

  * Normal
  * Warning
  * Critical
* Internet connectivity check
* Application detection
* Application executable path detection
* Command-line arguments for checking applications
* Colored health status indicators
* Overall server health status
* Linux system information

  * Current user
  * Hostname
  * Operating system
  * Uptime
* ShellCheck validated

## Requirements

* Linux
* Bash
* `bc`
* `ping`

## Usage

Clone the repository:

```bash
git clone git@github.com:Aliaaz-dev/Server-health-check.git
cd Server-health-check
```

Make the script executable:

```bash
chmod +x server-health.sh
```

Run the health checker:

```bash
./server-health.sh
```

### Check Applications

Applications can be passed as command-line arguments:

```bash
./server-health.sh nginx docker node java
```

The script checks whether each application is available as a command on the system and displays its executable path when installed.

Example:

```text
Services & Applications
----------------------------------------
Application    Status          Path
----------------------------------------
bash           Installed       /usr/bin/bash
node           Installed       /usr/bin/node
nginx          Not Installed   -
docker         Not Installed   -
```

If no applications are specified:

```bash
./server-health.sh
```

the script reports:

```text
Services & Applications
----------------------------------------
No applications specified
```

## Example Output

```text
========================================
       LINUX SERVER HEALTH CHECK
========================================

System
----------------------------------------
Current User   : 
Hostname       : 
OS             : 
Uptime         : 

CPU
-----------------------------------------
Usage          :
Status         : 

Memory
----------------------------------------
Total          : 
Available      : 
Usage          : 
Status         : 

Disk
----------------------------------------
Total          : 
Used           : 
Available      : 
Usage          : 
Status         : 

Services & Applications
----------------------------------------
Application    Status          Path
----------------------------------------
bash           Installed       /usr/bin/bash
node           Installed       /usr/bin/node
docker         Not Installed   -

Network
----------------------------------------
Internet       : Connected
Status         : Normal

========================================
Overall Status: Normal
========================================
```

## Health Status

The script classifies monitored resources according to their usage:

| Status   | Meaning                                        |
| -------- | ---------------------------------------------- |
| Normal   | Resource usage is within the healthy range     |
| Warning  | Resource usage is approaching a critical level |
| Critical | Resource usage has reached a critical level    |

Disk usage currently uses:

```text
< 70%     Normal
70–89%    Warning
≥ 90%     Critical
```

The overall status follows the highest severity detected:

```text
Critical
    ↑
Warning
    ↑
Normal
```

If any monitored resource is Critical, the overall status becomes Critical. Otherwise, if any resource is Warning, the overall status becomes Warning. If neither condition occurs, the overall status remains Normal.

## Project Structure

```text
Server-health-check/
│
├── server-health.sh
└── README.md
```

## Development

This project is being developed incrementally as part of my DevOps and Linux learning journey.

The current version focuses on practical Bash scripting concepts including:

* Variables
* Command substitution
* Conditional statements
* Loops
* Functions
* Command-line arguments
* Exit statuses
* Text processing with `awk`
* Linux system commands
* ANSI terminal colors
* Basic server monitoring

The script is tested locally on Linux and validated using ShellCheck.

## Roadmap

Future improvements may include:

* [ ] Configurable warning and critical thresholds
* [ ] Service/process monitoring
* [ ] Logging
* [ ] Automated monitoring with cron
* [ ] Alerts for critical conditions
* [ ] More detailed network monitoring
* [ ] Remote server monitoring
* [ ] Configuration file support

## License

MIT

