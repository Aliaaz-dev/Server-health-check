# Server Health Check

A lightweight Linux server health monitoring script written in Bash.

The project checks essential system resources and services to provide a quick overview of a server's health directly from the terminal.

## Planned Features

* [ ] CPU usage monitoring
* [ ] Memory usage monitoring
* [ ] Disk usage monitoring
* [ ] Service status checks
* [ ] Internet connectivity checks
* [ ] Configurable warning and critical thresholds
* [ ] Health status classification
* [ ] Logging
* [ ] Command-line arguments
* [ ] Automated monitoring with cron
* [ ] Alerts for critical conditions

## Requirements

* Linux
* Bash
* `sysstat` *(required for some CPU monitoring functionality)*

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

Run it:

```bash
./server-health.sh
```

## Example

```text
========================================
       LINUX SERVER HEALTH CHECK
========================================

System
----------------------------------------
Current User   : user
Hostname       : server
OS             : Linux
Uptime         : 3 days

CPU
----------------------------------------
Usage          : 23%
Status         : OK

Memory
----------------------------------------
Used           :
Usage          :
Status         :

Disk
----------------------------------------
/              :
Status         :

Services
----------------------------------------
nginx          :
mongodb        :
docker         :

Network
----------------------------------------
Internet       :

========================================
Overall Status:
========================================
```

## Project Goals

This project is being developed as part of my DevOps and Linux learning journey.

The goal is to build the utility incrementally while learning practical Bash scripting, Linux system administration, process management, resource monitoring, logging, automation, and server troubleshooting.

## Roadmap

The project will evolve from a basic Bash script into a more complete Linux server monitoring utility.

```text
System Information
        ↓
Resource Monitoring
        ↓
Service Monitoring
        ↓
Thresholds & Health Status
        ↓
Logging
        ↓
Automation
        ↓
Alerts
```

## License

MIT

