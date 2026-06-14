# Enterprise Hybrid Core & SysOps Automation

Welcome to my repository! This project is a complete breakdown of a Hybrid Cloud setup. It shows how I connect an On-Premise network (Cisco) with AWS Cloud infrastructure using Terraform, and how I automate server management using Bash scripts and Nginx.

I have organized everything into clean, separate folders so it is easy to navigate.

---

## 📁 What's Inside This Repository?

### 1. ☁️ AWS Infrastructure (`/aws-cloud-infra`)
*   `transit_gateway.tf`: My Terraform code to set up an AWS Transit Gateway. It acts as a central router to connect multiple VPCs and manage traffic securely.
*   `vpn_gateway.tf`: Base configurations to connect the cloud environment back to the on-premise datacenter.

### 2. 🌐 Cisco Networking (`/cisco-packet-tracer-labs`)
*   `edge_router_bgp.cfg`: BGP routing setup to ensure stable network paths between on-prem and cloud.
*   `edge_security_hardened.cfg`: Security rules (ACLs, SSH access) to lock down the edge routers and prevent unauthorized access.

### 3. 🐧 Linux Application Layer (`/enterprise-linux-appstack`)
*   `nginx_secure_proxy.conf`: A production-ready Nginx configuration acting as a secure Reverse Proxy with SSL/TLS settings and port forwardings.
*   `custom_app_watchdog.service`: A custom Linux systemd service that automatically restarts our monitoring apps if they crash.
*   `nginx_troubleshooting.md`: My quick-fix playbook for resolving real-world issues like `502 Bad Gateway` and port conflicts.

### 4. ⚙️ Automation Scripts (`/sysops-automation-toolkit`)
*   `core_netops_menu.sh`: A central interactive bash menu that allows you to run all diagnostic checks from one place.
*   **Diagnostic Utilities:** Individual scripts to check CPU/RAM health, parse system logs for errors, scan listening ports, check disk space, and verify network ping connectivity.

---

## 🚀 How to Run the Monitoring Dashboard

If you want to test the interactive administrative console locally on a Linux server, follow these quick steps:

```bash
# Move to the toolkit directory
cd ~/enterprise-hybrid-core/sysops-automation-toolkit

# Give execution permission to the master script
chmod +x core_netops_menu.sh

# Run the dashboard
./core_netops_menu.sh
